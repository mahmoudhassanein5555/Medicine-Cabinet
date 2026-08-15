import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/household/presentation/view/screens/widget/custom_button.dart';
import 'package:medicine_cabinet/features/household/presentation/view/screens/widget/custom_text_field.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view_model/household_state.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dialogs/app_toasts.dart';
import '../../../../../generated/l10n.dart';
import '../view_model/household_cubit.dart';
import 'household_members_screen.dart';

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
        listener: (context, state) {
          if (state is CreateHouseholdSuccess) {
            AppToast.showToast(
              context: context,
              title: 'Success',
              description: 'Household created successfully',
              type: ToastificationType.success,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HouseholdMembersScreen(householdId: state.household.id),
              ),
            );
          }
          if (state is CreateHouseholdError) {
            AppToast.showToast(
              context: context,
              title: 'Error',
              description: state.message,
              type: ToastificationType.error,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateHouseholdLoading;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: IconButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          l10n.createHouseholdTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          l10n.createHouseholdDescription,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 250,
                          child: Lottie.asset(
                            'assets/animations/create_household_screen.json',
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.householdNameLabel,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),

                        const SizedBox(height: 10),

                        CustomTextField(
                          controller: _nameController,
                          enabled: !isLoading,
                          hintText: l10n.householdNameHint,
                          prefixIcon: Icons.home_outlined,
                        ),

                        const SizedBox(height: 16),

                        CustomButton(
                          text: isLoading
                              ? 'Creating...'
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
                        const SizedBox(height: 18),

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

                        const SizedBox(height: 18),

                        CustomButton(
                          text: l10n.householdJoinExistingButton,
                          onPressed: isLoading
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
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
