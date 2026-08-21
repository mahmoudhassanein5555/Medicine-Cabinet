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
import '../cubit/low_stock_settings_cubit.dart';
import '../cubit/privacy_settings_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../cubit/reminder_settings_cubi.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_section.dart';
import '../widgets/profile_skeleton.dart';
import '../widgets/profile_switch_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (_) => getIt<ReminderSettingsCubit>()),
        BlocProvider(
          create: (_) => getIt<LowStockSettingsCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<PrivacySettingsCubit>(),
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
      // =====================================================
      // Listener
      // =====================================================
      listener: (context, state) {
        final strings = S.of(context);

        if (state is ProfileError) {
          AppToast.showToast(
            context: context,
            title: strings.commonTryAgain,
            description: ErrorLocalization.getMessage(state.message, strings),
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
            body: Center(
              child: Text(
                ErrorLocalization.getMessage(state.message, S.of(context)),
              ),
            ),
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
            // Reminders
            // =========================
            ProfileSection(
              title: strings.profileRemindersSection,
              children: [
                BlocBuilder<ReminderSettingsCubit, int>(
                  builder: (context, reminderDays) {
                    return ProfileOptionTile(
                      title: strings.profileExpiryReminderSettings,
                      trailingText: S
                          .of(context)
                          .profileDaysBefore(reminderDays),
                      onTap: () {
                        _showReminderSettingsDialog(context);
                      },
                    );
                  },
                ),

                BlocBuilder<LowStockSettingsCubit, int>(
                  builder: (context, threshold) {
                    return ProfileOptionTile(
                      title: strings.profileLowStockThreshold,
                      trailingText: strings.profileUnits(threshold),
                      onTap: () {
                        _showLowStockDialog(context);
                      },
                      showDivider: false,
                    );
                  },
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
                    _showPrivacyDialog(context);
                  },
                ),



                ProfileSwitchTile(
                  title: strings.profileDarkMode,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    context.read<AppSettingsCubit>().toggleTheme(value);
                  },
                ),

                _LanguageTile(showDivider: false),
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
  void _showLowStockDialog(BuildContext context) {
    final lowStockCubit = context.read<LowStockSettingsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: lowStockCubit,
          child: BlocBuilder<LowStockSettingsCubit, int>(
            builder: (context, currentThreshold) {
              final strings = S.of(context);

              return AlertDialog(
                title: Text(strings.profileLowStockThreshold),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LowStockOption(
                      threshold: 3,
                      currentThreshold: currentThreshold,
                    ),
                    _LowStockOption(
                      threshold: 5,
                      currentThreshold: currentThreshold,
                    ),
                    _LowStockOption(
                      threshold: 10,
                      currentThreshold: currentThreshold,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
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
  void _showPrivacyDialog(BuildContext context) {
    final privacyCubit = context.read<PrivacySettingsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: privacyCubit,
          child: BlocBuilder<PrivacySettingsCubit, bool>(
            builder: (context, showMedicineName) {
              final strings = S.of(context);

              return AlertDialog(
                title: Text(strings.profilePrivacy),
                content: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    strings.profileShowMedicineName,
                  ),
                  subtitle: Text(
                    strings.profileShowMedicineNameDescription,
                  ),
                  value: showMedicineName,
                  onChanged: (value) {
                    context
                        .read<PrivacySettingsCubit>()
                        .changeShowMedicineName(value);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
  // =====================================================
  void _showReminderSettingsDialog(BuildContext context) {
    final reminderCubit = context.read<ReminderSettingsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: reminderCubit,
          child: BlocBuilder<ReminderSettingsCubit, int>(
            builder: (context, currentDays) {
              final strings = S.of(context);

              return AlertDialog(
                title: Text(strings.profileExpiryReminderTitle),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ReminderOption(days: 7, currentDays: currentDays),
                    _ReminderOption(days: 14, currentDays: currentDays),
                    _ReminderOption(days: 30, currentDays: currentDays),
                  ],
                ),
              );
            },
          ),
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
class _ReminderOption extends StatelessWidget {
  final int days;
  final int currentDays;

  const _ReminderOption({required this.days, required this.currentDays});

  @override
  Widget build(BuildContext context) {
    final isSelected = days == currentDays;

    return ListTile(
      title: Text(S.of(context).profileDaysBefore(days)),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () async {
        await context.read<ReminderSettingsCubit>().changeReminderDays(days);

        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}

// =====================================================
class _LowStockOption extends StatelessWidget {
  final int threshold;
  final int currentThreshold;

  const _LowStockOption({
    required this.threshold,
    required this.currentThreshold,
  });

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final isSelected = threshold == currentThreshold;

    return ListTile(
      title: Text(strings.profileUnits(threshold)),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () async {
        await context.read<LowStockSettingsCubit>().changeThreshold(threshold);

        if (context.mounted) {
          Navigator.pop(context);
        }
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
