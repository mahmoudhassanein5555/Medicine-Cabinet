import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/custom_button.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/widget/custom_text_field.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view_model/household_state.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_cubit.dart';

class CreateHouseholdScreen extends StatefulWidget {
  const CreateHouseholdScreen({super.key, required this.userId});

  final String userId;

  @override
  State<CreateHouseholdScreen> createState() => _CreateHouseholdScreenState();
}

class _CreateHouseholdScreenState extends State<CreateHouseholdScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider(
      create: (_) => getIt<HouseholdCubit>(),
      child: BlocConsumer<HouseholdCubit, HouseholdState>(
        listener: (context, state) async {
          if (state is CreateHouseholdSuccess) {
            await getIt<HouseholdLocalDataSource>().saveHouseholdId(state.household.id);
            if (context.mounted) {
              AppToast.showToast(
                context: context,
                title: l10n.commonSuccess,
                description: l10n.householdCreatedSuccessfully,
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
          if (state is CreateHouseholdError) {
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
          final isLoading = state is CreateHouseholdLoading;
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

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20.r,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),
                        Text(
                          l10n.createHouseholdTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Text(
                          l10n.createHouseholdDescription,
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
                            'assets/animations/create_household_screen.json',
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.householdNameLabel,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        CustomTextField(
                          controller: _nameController,
                          enabled: !isLoading,
                          hintText: l10n.householdNameHint,
                          prefixIcon: Icons.home_outlined,
                        ),

                        SizedBox(height: 16.h),

                        CustomButton(
                          text: isLoading
                              ? l10n.householdCreating
                              : l10n.householdCreateButton,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context
                                      .read<HouseholdCubit>()
                                      .createHousehold(
                                        name: _nameController.text.trim(),
                                        userId: widget.userId,
                                      );
                                },
                        ),
                        SizedBox(height: 18.h),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: colorScheme.outline,
                                thickness: 1.2.w,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 12.w,
                              ),
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

                        SizedBox(height: 18.h),

                        CustomButton(
                          text: l10n.householdJoinExistingButton,
                          onPressed: isLoading
                              ? null
                              : () {
                                  Navigator.pop(context);
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
