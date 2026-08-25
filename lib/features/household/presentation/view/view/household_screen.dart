import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/core/utils/shared_prefs_local_data_source.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/custom_button.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/custom_text_field.dart';
import 'package:toastification/toastification.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_cubit.dart';
import '../view_model/household_state.dart';
import 'create_household_screen.dart';
import 'household_qr_scanner_screen.dart';

class HouseholdScreen extends StatefulWidget {
  const HouseholdScreen({
    super.key,
    required this.userId,
    this.onCreatePressed,
  });

  final String userId;
  final VoidCallback? onCreatePressed;

  @override
  State<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
  final TextEditingController _householdIdController = TextEditingController();
  late CacheHelper _cacheHelper;
  late String userId;

  @override
  void initState() {
    _cacheHelper = getIt<CacheHelper>();
    userId =
        _cacheHelper.getData(key: AppKeys.userId) as String? ?? widget.userId;
    super.initState();
  }

  @override
  void dispose() {
    _householdIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) =>
          getIt<HouseholdCubit>()..getUserHousehold(userId: widget.userId),
      child: BlocConsumer<HouseholdCubit, HouseholdState>(
        listener: (context, state) async {
          if (state is GetHouseholdSuccess) {
            final household = state.household;

            if (household != null) {
              await getIt<HouseholdLocalDataSource>().saveHouseholdId(
                household.id,
              );
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomBottomNavBar(
                      userId: userId,
                      householdId: household.id,
                    ),
                  ),
                );
              }
            }
          }

          if (state is CreateHouseholdSuccess) {
            await getIt<HouseholdLocalDataSource>().saveHouseholdId(
              state.household.id,
            );
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomBottomNavBar(
                    userId: widget.userId,
                    householdId: state.household.id,
                  ),
                ),
              );
            }
          }

          if (state is JoinHouseholdSuccess) {
            await getIt<HouseholdLocalDataSource>().saveHouseholdId(
              state.household.id,
            );
            if (context.mounted) {
              AppToast.showToast(
                context: context,
                title: l10n.commonSuccess,
                description: l10n.householdJoinSuccess,
                type: ToastificationType.success,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomBottomNavBar(
                    userId: widget.userId,
                    householdId: state.household.id,
                  ),
                ),
              );
            }
          }

          if (state is GetHouseholdError) {
            if (context.mounted) {
              AppToast.showToast(
                context: context,
                title: l10n.commonError,
                description: state.failure.getMessage(context),
                type: ToastificationType.error,
              );
            }
          }

          if (state is JoinHouseholdError) {
            if (context.mounted) {
              AppToast.showToast(
                context: context,
                title: l10n.commonError,
                description: state.failure.getMessage(context),
                type: ToastificationType.error,
              );
            }
          }
        },
        builder: (context, state) {
          final isCheckingHousehold = state is GetHouseholdLoading;
          final isLoading =
              isCheckingHousehold ||
              state is JoinHouseholdLoading ||
              state is CreateHouseholdLoading;

          if (isCheckingHousehold) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(14.r),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),

                        Text(
                          l10n.householdSetupTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Text(
                          l10n.householdSetupDescription,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        SizedBox(
                          width: double.infinity,
                          height: 250.h,
                          child: Lottie.asset(
                            'assets/animations/household_screen.json',
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.householdIdLabel,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),

                        CustomTextField(
                          controller: _householdIdController,
                          enabled: !isLoading,
                          hintText: l10n.householdIdHint,
                          prefixIcon: Icons.home_outlined,
                          suffixIcon: IconButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<HouseholdCubit>(),
                                          child: HouseholdQrScannerScreen(
                                            userId: widget.userId,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                            icon: Icon(Icons.qr_code_scanner, size: 24.r),
                          ),
                        ),

                        SizedBox(height: 20.h),
                        CustomButton(
                          text: state is JoinHouseholdLoading
                              ? l10n.householdJoining
                              : l10n.householdJoinButton,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<HouseholdCubit>().joinHousehold(
                                    householdId: _householdIdController.text,
                                    userId: widget.userId,
                                  );
                                },
                        ),

                        SizedBox(height: 32.h),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: colorScheme.outline,
                                thickness: 1.2.w,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                l10n.householdOr,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.sp,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: colorScheme.outline,
                                thickness: 1.2.w,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),
                        CustomButton(
                          text: l10n.householdCreateButton,
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (widget.onCreatePressed != null) {
                                    widget.onCreatePressed!();
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CreateHouseholdScreen(
                                          userId: widget.userId,
                                        ),
                                      ),
                                    );
                                  }
                                },
                          isOutlined: true,
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
