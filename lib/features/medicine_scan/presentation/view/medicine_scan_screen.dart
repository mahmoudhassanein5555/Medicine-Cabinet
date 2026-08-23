import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view/widgets/camera_screen.dart';
import 'package:medicine_cabinet/features/medicine_scan/presentation/view_model/medicine_scan_cubit.dart';

class MedicineScanScreen extends StatelessWidget {
  const MedicineScanScreen({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MedicineScanCubit>(),
      child: CameraScreen(cameras: cameras),
    );
  }
}
