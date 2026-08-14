import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Icon Header
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.all_inbox_rounded,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 24),

                // Title & Subtitle
                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Set up your household\'s medicine cabinet in a minute.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 28),

                // Full Name
                const Text(
                  'Full name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Ahmed Farouk',
                  hintTextColor: AppColors.textMuted,
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.textMuted),
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 16),

                // Email
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'ahmed@family.mail',
                  hintTextColor: AppColors.textMuted,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textMuted),
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 16),

                // Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: '••••••••',
                  hintTextColor: AppColors.textMuted,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 16),

                // Confirm Password
                const Text(
                  'Confirm password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: '••••••••',
                  hintTextColor: AppColors.textMuted,
                  isPassword: true,
                  action: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 28),

                // Submit Button
                CustomButton(
                  text: 'Create account',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Trigger Register Event
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Terms Notice
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'By continuing, you agree to the Terms and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate back to LoginView
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
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
  }
}