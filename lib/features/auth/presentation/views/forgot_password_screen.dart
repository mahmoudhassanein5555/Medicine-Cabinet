import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AppToast.showToast(
            context: context,
            title: l10n.authResetPasswordTitle,
            description: l10n.authResetPasswordSuccess,
            type: ToastificationType.success,
          );

          Navigator.pop(context);
        }

        if (state is AuthError) {
          AppToast.showToast(
            context: context,
            title: l10n.commonError,
            description: ErrorLocalization.getMessage(
              state.message,
              l10n,
            ),
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: Text(l10n.authForgotPassword),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    Icon(
                      Icons.lock_reset_rounded,
                      size: 64,
                      color: colorScheme.primary,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      l10n.authResetPasswordTitle,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      l10n.authResetPasswordSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    Text(
                      l10n.authEmailLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'ahmed@family.mail',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 28),

                    CustomButton(
                      text: isLoading
                          ? l10n.authSendingResetEmail
                          : l10n.authSendResetEmail,
                      isLoading: isLoading,
                      onPressed: () {
                        if (isLoading) return;

                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().forgotPassword(
                            email: emailController.text.trim(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}