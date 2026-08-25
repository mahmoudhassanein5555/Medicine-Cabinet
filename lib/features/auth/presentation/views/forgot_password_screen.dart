import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/utils/validator_functions.dart';
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
            description: state.failure.getMessage(context),
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: Text(
              l10n.authForgotPassword,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.r),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    Icon(
                      Icons.lock_reset_rounded,
                      size: 64.r,
                      color: colorScheme.primary,
                    ),

                    SizedBox(height: 24.h),

                    Text(
                      l10n.authResetPasswordTitle,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      l10n.authResetPasswordSubtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    Text(
                      l10n.authEmailLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'ahmed@family.mail',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        final error = Validator.validateEmail(value);
                        if (error == null) return null;
                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme.onSurfaceVariant,
                        size: 20.r,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),

                    SizedBox(height: 28.h),

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