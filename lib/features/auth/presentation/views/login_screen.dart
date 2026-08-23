import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medicine_cabinet/features/auth/presentation/views/register_screen.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/google_button.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'forgot_password_screen.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          AppToast.showToast(
            context: context,
            title: l10n.authLoginButton,
            description: l10n.authLoginSuccess,
            type: ToastificationType.success,
          );
          // TODO: Navigate to Home
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
        final isLoginLoading =
            state is AuthLoading &&
                state.action == AuthAction.login;

        final isGoogleLoading =
            state is AuthLoading &&
                state.action == AuthAction.googleSignIn;

        return Scaffold(
          backgroundColor: colorScheme.surface,
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email Field
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

                    const SizedBox(height: 20),

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

                    // Password Field
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '••••••••',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      isPassword: true,
                      action: TextInputAction.done,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<AuthCubit>(),
                                child: const ForgotPasswordScreen(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          l10n.authForgotPassword,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Login Button
                    CustomButton(
                      text: isLoginLoading
                          ? l10n.authLoggingIn
                          : l10n.authLoginButton,
                      onPressed: () {
                        if (isLoginLoading) return;

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
                        Expanded(
                          child: Divider(
                            color: colorScheme.outline,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Text(
                            l10n.commonOr,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: colorScheme.outline,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Google Sign In
                    GoogleButton(
                      isLoading: isGoogleLoading,
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
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
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