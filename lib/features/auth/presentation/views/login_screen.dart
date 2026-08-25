import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:medicine_cabinet/features/auth/presentation/views/register_screen.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/widgets/google_button.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/household_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/utils/validator_functions.dart';
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

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HouseholdScreen(userId: state.user.id),
            ),
            (route) => false,
          );
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
        final isLoginLoading =
            state is AuthLoading && state.action == AuthAction.login;

        final isGoogleLoading =
            state is AuthLoading && state.action == AuthAction.googleSignIn;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 16.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Header
                    AuthHeader(
                      title: l10n.authLoginTitle,
                      subtitle: l10n.authLoginSubtitle,
                    ),

                    SizedBox(height: 32.h),

                    // Email Label
                    Text(
                      l10n.authEmailLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Email Field
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

                    SizedBox(height: 20.h),

                    // Password Label
                    Text(
                      l10n.authPasswordLabel,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Password Field
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '••••••••',
                      hintTextColor: colorScheme.onSurfaceVariant,
                      isPassword: true,
                      action: TextInputAction.done,
                      validator: (value) {
                        final error = Validator.validatePassword(value);
                        if (error == null) return null;
                        return ErrorLocalization.getMessage(error, l10n);
                      },
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colorScheme.onSurfaceVariant,
                        size: 20.r,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
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
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

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

                    SizedBox(height: 24.h),

                    // OR
                    Row(
                      children: [
                        Expanded(child: Divider(color: colorScheme.outline)),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            l10n.commonOr,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),

                        Expanded(child: Divider(color: colorScheme.outline)),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    // Google Sign In
                    GoogleButton(
                      isLoading: isGoogleLoading,
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.authNoAccount,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 14.sp,
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
                              fontSize: 14.sp,
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
