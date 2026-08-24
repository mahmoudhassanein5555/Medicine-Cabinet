import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_state.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/login_screen.dart';
import 'package:medicine_cabinet/features/profile/presentation/view/personal_information_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/settings/app_settings_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/profile_entity.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_skeleton.dart';
import '../widgets/profile_switch_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. استخدام MultiBlocProvider لتوفير الـ AuthCubit والـ ProfileCubit
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..loadProfile(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
      ],
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        final strings = S.of(context);

        if (state is ProfileError) {
          AppToast.showToast(
            context: context,
            title: strings.commonTryAgain,
            description: state.failure.getMessage(context),
            type: ToastificationType.error,
          );
        }
      },

      builder: (context, state) {
        // =========================
        // Loading
        // =========================

        if (state is ProfileLoading) {
          return const ProfileSkeleton();
        }

        // =========================
        // Loaded
        // =========================

        if (state is ProfileLoaded) {
          return _buildContent(context, state.profile);
        }

        if (state is ProfileUpdateSuccess) {
          return _buildContent(context, state.profile);
        }

        // =========================
        // Error
        // =========================

        if (state is ProfileError) {
          return Scaffold(
            body: Center(child: Text(state.failure.getMessage(context))),
          );
        }

        return const Scaffold(body: Center(child: ProfileSkeleton()));
      },
    );
  }

  // =====================================================
  // Profile Content
  // =====================================================

  Widget _buildContent(BuildContext context, ProfileEntity profile) {
    final strings = S.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // =========================
            // Profile Header
            // =========================
            ProfileHeader(profile: profile),

            const SizedBox(height: 24),

            // =========================
            // Account
            // =========================
            ProfileSection(
              title: strings.profileAccountSection,
              children: [
                ProfileOptionTile(
                  title: strings.profilePersonalInformation,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileCubit>(),
                          child: PersonalInformationScreen(profile: profile),
                        ),
                      ),
                    );
                  },
                ),

                ProfileOptionTile(
                  title: strings.commonHousehold,
                  onTap: () {
                    // TODO: Open Household Screen
                  },
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // App
            // =========================
            ProfileSection(
              title: strings.profileAppSection,
              children: [
                // Dark Mode
                ProfileSwitchTile(
                  title: strings.profileDarkMode,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    context.read<AppSettingsCubit>().toggleTheme(value);
                  },
                ),

                // Language
                const _LanguageTile(showDivider: true),

                // App Version
                ProfileOptionTile(
                  title: strings.profileAppVersion,
                  trailingText: '1.0.0',
                  showDivider: false,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // Information
            // =========================
            ProfileSection(
              title: strings.profileInformationSection,
              children: [
                ProfileOptionTile(
                  title: strings.profileAbout,
                  onTap: () {
                    _showAboutDialog(context);
                  },
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================
            // Logout
            // =========================
            BlocConsumer<AuthCubit, AuthState>(
              listener: (BuildContext context, state) {
                if (state is AuthInitial) {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => getIt<AuthCubit>(),
                        child: const LoginScreen(),
                      ),
                    ),
                    (route) => false,
                  );
                } else if (state is AuthError) {
                  AppToast.showToast(
                    context: context,
                    title: strings.commonError,
                    description: state.failure.getMessage(context),
                    type: ToastificationType.error,
                  );
                }
              },
              builder: (BuildContext context, state) {
                if (state is AuthLoading && state.action == AuthAction.logout) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Material(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: ProfileOptionTile(
                    title: strings.profileLogout,
                    color: Colors.red,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    showDivider: false,
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // About Dialog
  // =====================================================

  void _showAboutDialog(BuildContext context) {
    final strings = S.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(strings.profileAbout),
          content: Text(strings.profileAboutDescription),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(strings.commonClose),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // Logout Dialog
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
    final strings = S.of(context);

    AppDialogs.showCustomDialog(
      context: context,
      title: strings.profileLogout,
      content: strings.profileLogoutConfirmation,
      cancelText: strings.commonCancel,
      confirmText: strings.profileLogout,
      onConfirm: () {
        context.read<AuthCubit>().logout();
      },
    );
  }
}

// =====================================================
// Language Dropdown
// =====================================================

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({this.showDivider = true});

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.watch<AppSettingsCubit>();

    final currentLanguage = appSettings.state.locale.languageCode;

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).profileLanguage,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentLanguage,
                  borderRadius: BorderRadius.circular(12),
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(S.of(context).profileEnglish),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(S.of(context).profileArabic),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    context.read<AppSettingsCubit>().changeLanguage(
                      value == 'ar',
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.8,
            indent: 16,
            endIndent: 16,
            color: colorScheme.outline,
          ),
      ],
    );
  }
}