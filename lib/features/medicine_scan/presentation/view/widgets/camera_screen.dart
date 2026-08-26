import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_cabinet/core/dialogs/app_toasts.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/camera_bottom_controls.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/camera_top_bar.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/confirmation_medicine_screen.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/scan_loading_dialog.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/scan_overlay_frame.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_cubit.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_states.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  int _selectedCameraIndex = 0;
  bool _isFlashOn = false;
  bool _isCapturing = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera(_selectedCameraIndex);
  }

  void _initCamera(int cameraIndex) {
    if (widget.cameras.isEmpty) return;

    _controller = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    _controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            debugPrint('Camera initialization error: ${e.code}');
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (!_controller.value.isInitialized) return;

    try {
      final newFlashState = !_isFlashOn;
      await _controller.setFlashMode(
        newFlashState ? FlashMode.torch : FlashMode.off,
      );
      setState(() {
        _isFlashOn = newFlashState;
      });
    } catch (e) {
      debugPrint('Error toggling flash: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (widget.cameras.length < 2) return;

    final nextIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    await _controller.dispose();
    setState(() {
      _selectedCameraIndex = nextIndex;
      _isFlashOn = false;
    });
    _initCamera(_selectedCameraIndex);
  }

  Future<void> _capturePhoto() async {
    if (!_controller.value.isInitialized ||
        _isCapturing ||
        _controller.value.isTakingPicture) {
      return;
    }

    try {
      setState(() => _isCapturing = true);
      final cubit = context.read<MedicineScanCubit>();
      final XFile image = await _controller.takePicture();

      if (!mounted) return;
      setState(() => _isCapturing = false);

      final File imageFile = File(image.path);
      cubit.analyzeMedicine(imageFile);
    } catch (e) {
      if (mounted) {
        setState(() => _isCapturing = false);
      }
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final cubit = context.read<MedicineScanCubit>();
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null && mounted) {
        final File imageFile = File(pickedFile.path);
        cubit.analyzeMedicine(imageFile);
      }
    } catch (e) {
      debugPrint('Error picking from gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cameras.isEmpty || !_controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    final double bottomBarHeight = 150.0.h;
    final previewSize = _controller.value.previewSize!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<MedicineScanCubit, MedicineScanStates>(
        listener: (context, state) {
          if (state is MedicineScanLoadingState) {
            ScanLoadingDialog.show(context);
          } else if (state is MedicineScanSuccessState ||
              state is MedicineScanErrorState) {
            ScanLoadingDialog.hide(context);

            if (state is MedicineScanSuccessState) {
              final scanCubit = context.read<MedicineScanCubit>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: scanCubit,
                    child: const ConfirmMedicineScreen(),
                  ),
                ),
              );
            } else if (state is MedicineScanErrorState) {
              AppToast.showToast(
                context: context,
                title: S.of(context).commonError,
                description: state.failure.getMessage(context),
                type: ToastificationType.error,
              );
            }
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: previewSize.height,
                  height: previewSize.width,
                  child: CameraPreview(_controller),
                ),
              ),
            ),
            ScanOverlayFrame(bottomBarHeight: bottomBarHeight),
            CameraTopBar(
              isFlashOn: _isFlashOn,
              onToggleFlash: _toggleFlash,
              onClose: () => Navigator.maybePop(context),
            ),
            CameraBottomControls(
              bottomBarHeight: bottomBarHeight,
              onCapture: _capturePhoto,
              onPickGallery: _pickFromGallery,
              onSwitchCamera: _switchCamera,
              isCapturing: _isCapturing,
            ),
          ],
        ),
      ),
    );
  }
}
