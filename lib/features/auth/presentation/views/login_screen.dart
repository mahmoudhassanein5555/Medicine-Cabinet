import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/register_screen.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/google_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_state.dart';
import '../cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // TODO: Navigate to Home
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.background,
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
                      title: l10n.authLoginTitle,
                      subtitle: l10n.authLoginSubtitle,
                    ),

                    const SizedBox(height: 32),

                    // Email Label
                    Text(
                      l10n.authEmailLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email Field
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'ahmed@family.mail',
                      hintTextColor: AppColors.textMuted,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.textMuted,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    const SizedBox(height: 20),

                    // Password Label
                    Text(
                      l10n.authPasswordLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Password Field
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '••••••••',
                      hintTextColor: AppColors.textMuted,
                      isPassword: true,
                      action: TextInputAction.done,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.textMuted,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Forgot password
                        },
                        child: Text(
                          l10n.authForgotPassword,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Login Button
                    CustomButton(
                      text: isLoading
                          ? l10n.authLoggingIn
                          : l10n.authLoginButton,
                      onPressed: () {
                        if (isLoading) return;

                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    // OR
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.border,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            l10n.commonOr,
                            style: const TextStyle(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),

                        const Expanded(
                          child: Divider(
                            color: AppColors.border,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Google Sign In
                    GoogleButton(
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                    ),

                    const SizedBox(height: 32),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.authNoAccount,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => getIt<AuthCubit>(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            l10n.authSignUpLink,
                            style: const TextStyle(
                              color: AppColors.primary,
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