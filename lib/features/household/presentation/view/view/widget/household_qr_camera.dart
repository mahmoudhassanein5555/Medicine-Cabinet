import 'package:flutter/material.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/scanner_overlay.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/scanner_top_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HouseholdQrCamera extends StatefulWidget {
  const HouseholdQrCamera({
    super.key,
    required this.onDetect,
    required this.isJoining,
    required this.onClose,
    required this.title,
  });

  final ValueChanged<String> onDetect;
  final bool isJoining;
  final VoidCallback onClose;
  final String title;

  @override
  State<HouseholdQrCamera> createState() => _HouseholdQrCameraState();
}

class _HouseholdQrCameraState extends State<HouseholdQrCamera> {
  late final MobileScannerController _controller;

  bool _hasScanned = false;

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
    if (_hasScanned || widget.isJoining) return;

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;

      if (value == null || value.trim().isEmpty) {
        continue;
      }

      _hasScanned = true;
      _controller.stop();

      widget.onDetect(value.trim());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(controller: _controller, onDetect: _onDetect),

        const ScannerOverlay(),

        ValueListenableBuilder<MobileScannerState>(
          valueListenable: _controller,
          builder: (context, state, child) {
            return ScannerTopBar(
              title: widget.title,
              isJoining: widget.isJoining,
              onClose: widget.onClose,
              onToggleTorch: _controller.toggleTorch,
              torchState: state.torchState,
            );
          },
        ),
      ],
    );
  }
}
