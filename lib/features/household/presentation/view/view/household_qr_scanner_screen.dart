import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/household_qr_camera.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/scanner_instruction.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/scanner_loading_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../core/utils/household_local_data_source.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_qr_scanner_cubit.dart';
import '../view_model/household_qr_scanner_state.dart';

class HouseholdQrScannerScreen extends StatelessWidget {
  const HouseholdQrScannerScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocProvider(
      create: (_) => getIt<HouseholdQrScannerCubit>(),
      child: BlocListener<HouseholdQrScannerCubit, HouseholdQrScannerState>(
        listener: (context, state) async {
          if (state is HouseholdQrScannerSuccess) {
            await getIt<HouseholdLocalDataSource>().saveHouseholdId(
              state.household.id,
            );

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
                  userId: userId,
                  householdId: state.household.id,
                ),
              ),
                  (_) => false,
            );
          }

          if (state is HouseholdQrScannerError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: state.failure.getMessage(context),
              type: ToastificationType.error,
            );
          }
        },
        child: BlocBuilder<
            HouseholdQrScannerCubit,
            HouseholdQrScannerState
        >(
          builder: (context, state) {
            final isJoining = state is HouseholdQrScannerJoining;

            return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  HouseholdQrCamera(
                    title: l10n.householdQrScannerTitle,
                    isJoining: isJoining,
                    onClose: () => Navigator.pop(context),
                    onDetect: (householdId) {
                      context
                          .read<HouseholdQrScannerCubit>()
                          .scanHousehold(
                        householdId: householdId,
                        userId: userId,
                      );
                    },
                  ),

                  ScannerInstruction(
                    text: l10n.householdQrScannerInstruction,
                  ),

                  if (isJoining)
                    ScannerLoadingOverlay(
                      message: l10n.householdJoining,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}