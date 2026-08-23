import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_state.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/utils/validator_functions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AppToast.showToast(
            context: context,
            title: l10n.authRegisterButton,
            description: l10n.authRegisterSuccess,
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

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Header
                    AuthHeader(
                      title: l10n.authRegisterTitle,
                      subtitle: l10n.authRegisterSubtitle,
                    ),

                    const SizedBox(height: 28),

                    // Full Name Label
                    Text(
                      l10n.authFullNameLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Full Name
                    CustomTextFormField(
                      controller: nameController,
                      hintText: 'Ahmed Farouk',
                      validator: (value) {
                        final error = Validator.validateName(value);

                        if (error == null) {
                          return null;
                        }

                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      hintTextColor: colorScheme.onSurfaceVariant,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 16),

                    // Email Label
                    Text(
                      l10n.authEmailLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'ahmed@family.mail',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        final error = Validator.validateEmail(value);

                        if (error == null) {
                          return null;
                        }

                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 16),

                    // Password Label
                    Text(
                      l10n.authPasswordLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Password
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '••••••••',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      isPassword: true,
                      validator: (value) {
                        final error = Validator.validatePassword(value);

                        if (error == null) {
                          return null;
                        }

                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password Label
                    Text(
                      l10n.authConfirmPasswordLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Confirm Password
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      hintText: '••••••••',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      isPassword: true,
                      action: TextInputAction.done,
                      validator: (value) {
                        final error = Validator.validateConfirmPassword(
                          value,
                          passwordController.text,
                        );
                        if (error == null) {
                          return null;
                        }
                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 28),

                    // Submit Button
                    CustomButton(
                      text: isLoading
                          ? l10n.authCreatingAccount
                          : l10n.authRegisterButton,
                      onPressed: () {
                        if (isLoading) return;

                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 16),

                    // Terms Notice
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          l10n.authTermsNotice,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.authHaveAccount,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            l10n.authLoginLink,
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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