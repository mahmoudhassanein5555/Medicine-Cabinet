import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/scanner_overlay.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../core/utils/household_local_data_source.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';

class HouseholdQrScannerScreen extends StatefulWidget {
  const HouseholdQrScannerScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<HouseholdQrScannerScreen> createState() =>
      _HouseholdQrScannerScreenState();
}

class _HouseholdQrScannerScreenState
    extends State<HouseholdQrScannerScreen> {
  late final MobileScannerController _controller;

  bool _isScanned = false;
  bool _isJoining = false;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned || _isJoining) return;

    for (final barcode in capture.barcodes) {
      final householdId = barcode.rawValue;

      if (householdId == null || householdId.trim().isEmpty) {
        continue;
      }

      _isScanned = true;
      _controller.stop();

      _joinHousehold(householdId.trim());
      return;
    }
  }

  void _joinHousehold(String householdId) {
    setState(() {
      _isJoining = true;
    });

    context.read<HouseholdCubit>().joinHousehold(
      householdId: householdId,
      userId: widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<HouseholdCubit, HouseholdState>(
      listener: (context, state) async {
        if (state is JoinHouseholdSuccess) {
          await getIt<HouseholdLocalDataSource>()
              .saveHouseholdId(state.household.id);

          if (!context.mounted) return;

          AppToast.showToast(
            context: context,
            title: l10n.commonSuccess,
            description: l10n.householdJoinSuccess,
            type: ToastificationType.success,
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => CustomBottomNavBar(
                userId: widget.userId,
                householdId: state.household.id,
              ),
            ),
                (route) => false,
          );
        }

        if (state is JoinHouseholdError) {
          if (!context.mounted) return;

          setState(() {
            _isJoining = false;
            _isScanned = false;
          });

          _controller.start();

          AppToast.showToast(
            context: context,
            title: l10n.commonError,
            description: state.failure.getMessage(context),
            type: ToastificationType.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
            ),

            const ScannerOverlay(),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 14.h,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _isJoining
                          ? null
                          : () => Navigator.pop(context),
                      child: Container(
                        width: 48.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28.r,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            l10n.householdQrScannerTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: _controller.toggleTorch,
                      child: Container(
                        width: 50.r,
                        height: 50.r,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child:
                        ValueListenableBuilder<MobileScannerState>(
                          valueListenable: _controller,
                          builder: (context, state, child) {
                            return Icon(
                              state.torchState == TorchState.on
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: Colors.white,
                              size: 25.r,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 125.h,
              left: 35.w,
              right: 35.w,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.center_focus_strong,
                        color: colorScheme.primary,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          l10n.householdQrScannerInstruction,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_isJoining)
              Container(
                color: Colors.black.withValues(alpha: 0.55),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          l10n.householdJoining,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}