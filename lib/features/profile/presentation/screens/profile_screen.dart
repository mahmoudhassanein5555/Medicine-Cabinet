import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_toasts.dart';
import '../../../../core/localization/error_localization.dart';
import '../../../../core/settings/app_settings_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/profile_entity.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_skeleton.dart';
import '../widgets/profile_switch_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      // =====================================================
      // Listener
      // =====================================================
      listener: (context, state) {
        final strings = S.of(context);

        if (state is ProfileError) {
          AppToast.showToast(
            context: context,
            title: strings.commonTryAgain,
            description: ErrorLocalization.getMessage(
              state.message,
              strings,
            ),
            type: ToastificationType.error,
          );
        }
      },

      // =====================================================
      // Builder
      // =====================================================

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
          return _buildContent(
            context,
            state.profile,
          );
        }
        if (state is ProfileUpdateSuccess) {
          return _buildContent(
            context,
            state.profile,
          );
        }

        // =========================
        // Error
        // =========================

        if (state is ProfileError) {
          return const Scaffold(
            body: SizedBox.shrink(),
          );
        }

        return const Scaffold(
          body: SizedBox.shrink(),
        );
      },
    );
  }

  // =====================================================
  // Profile Content
  // =====================================================

  Widget _buildContent(
      BuildContext context,
      ProfileEntity profile,
      ) {
    final strings = S.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // =========================
            // Profile Header
            // =========================

            ProfileHeader(
              profile: profile,
            ),

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
                          child: PersonalInformationScreen(
                            profile: profile,
                          ),
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
            // Reminders
            // =========================

            ProfileSection(
              title: strings.profileRemindersSection,
              children: [
                ProfileOptionTile(
                  title: strings.profileExpiryReminderSettings,
                  trailingText: '14 days before',
                  onTap: () {
                    // TODO: Open Expiry Reminder Settings
                  },
                ),

                ProfileOptionTile(
                  title: 'Low-stock threshold',
                  trailingText: '5 units',
                  onTap: () {
                    // TODO: Open Low-stock Threshold
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
                ProfileOptionTile(
                  title: strings.profilePrivacy,
                  onTap: () {
                    // TODO: Open Privacy
                  },
                ),

                ProfileOptionTile(
                  title: strings.profileAppPreferences,
                  onTap: () {
                    // TODO: Open App Preferences
                  },
                ),

                ProfileSwitchTile(
                  title: strings.profileDarkMode,
                  value: Theme.of(context).brightness ==
                      Brightness.dark,
                  onChanged: (value) {
                    context
                        .read<AppSettingsCubit>()
                        .toggleTheme(value);
                  },
                ),

                _LanguageTile(
                  showDivider: false,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================
            // Information
            // =========================

            ProfileSection(
              title: 'Information',
              children: [
                ProfileOptionTile(
                  title: 'About',
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

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ProfileOptionTile(
                title: strings.profileLogout,
                color: Colors.red,
                onTap: () {
                  _showLogoutDialog(context);
                },
                showDivider: false,
              ),
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Medicine Cabinet'),
          content: const Text(
            'Medicine Cabinet helps you manage your medicines, '
                'reminders, expiry dates, and stock levels easily.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
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
      cancelText: strings.profileCancel,
      confirmText: strings.profileLogout,
      confirmButtonColor: Colors.red,
      onConfirm: () {
        // TODO: Connect logout logic
      },
    );
  }
}

// =====================================================
// Language Dropdown
// =====================================================

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    this.showDivider = true,
  });

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final appSettings = context.watch<AppSettingsCubit>();
    final currentLanguage =
        appSettings.state.locale.languageCode;

    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Language',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentLanguage,
                  borderRadius: BorderRadius.circular(12),
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    context
                        .read<AppSettingsCubit>()
                        .changeLanguage(
                      value == 'ar',
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color:
                    colorScheme.onSurfaceVariant,
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



