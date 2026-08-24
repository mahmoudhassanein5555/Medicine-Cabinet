import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
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
import 'household_members_screen.dart';

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
  void initState()  {
    _cacheHelper = getIt<CacheHelper>();
    userId = _cacheHelper.getData(key: AppKeys.userId);
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
        listener: (context, state) {
          if (state is GetHouseholdSuccess) {
            final household = state.household;

            if (household != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomBottomNavBar(
                    userId: userId,
                    householdId: state.household?.id,
                  ),
                ),
              );
            }
          }

          if (state is CreateHouseholdSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HouseholdMembersScreen(
                  householdId: state.household.id,
                  userId: widget.userId,
                ),
              ),
            );
          }

          if (state is JoinHouseholdSuccess) {
            AppToast.showToast(
              context: context,
              title: l10n.commonSuccess,
              description: l10n.householdJoinSuccess,
              type: ToastificationType.success,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HouseholdMembersScreen(
                  householdId: state.household.id,
                  userId: widget.userId,
                ),
              ),
            );
          }

          if (state is GetHouseholdError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: state.failure.getMessage(context),
              type: ToastificationType.error,
            );
          }

          if (state is JoinHouseholdError) {
            AppToast.showToast(
              context: context,
              title: l10n.commonError,
              description: state.failure.getMessage(context),
              type: ToastificationType.error,
            );
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
                padding: const EdgeInsets.all(14.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        Text(
                          l10n.householdSetupTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          l10n.householdSetupDescription,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 17,
                          ),
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: Lottie.asset(
                            'assets/animations/household_screen.json',
                            repeat: true,
                          ),
                        ),

                        const SizedBox(height: 30),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.householdIdLabel,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        CustomTextField(
                          controller: _householdIdController,
                          enabled: !isLoading,
                          hintText: l10n.householdIdHint,
                          prefixIcon: Icons.home_outlined,
                        ),

                        const SizedBox(height: 20),
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

                        const SizedBox(height: 32),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: colorScheme.outline,
                                thickness: 1.2,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                l10n.householdOr,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: colorScheme.outline,
                                thickness: 1.2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        CustomButton(
                          text: l10n.householdCreateButton,
                          onPressed: isLoading ? null : widget.onCreatePressed,
                          isOutlined: true,
                        ),

                        const SizedBox(height: 24),
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
