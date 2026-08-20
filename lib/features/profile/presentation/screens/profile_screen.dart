import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/features/profile/presentation/screens/personal_information_screen.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/settings/app_settings_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/profile_entity.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';
import '../widgets/profile_section.dart';
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is ProfileError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        }

        if (state is ProfileLoaded) {
          return _buildContent(
            context,
            state.profile,
          );
        }

        return const Scaffold(
          body: SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context,
      ProfileEntity profile,
      ) {
    final strings = S.of(context);

    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              ProfileHeader(
                profile: profile,
              ),

              const SizedBox(height: 24),

              // Account
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
                            value: context.read<ProfileCubit>(), // هنا بنمرر الـ Cubit الموجود بالفعل
                            child: PersonalInformationScreen(profile: profile),
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileOptionTile(
                    title: strings.commonHousehold,
                    onTap: () {
                      // TODO: Open Household
                    },
                    showDivider: false,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Reminders
              ProfileSection(
                title: strings.profileRemindersSection,
                children: [
                  ProfileOptionTile(
                    title: strings.profileNotificationSettings,
                    onTap: () {
                      // TODO: Open Notification Settings
                    },
                  ),
                  ProfileOptionTile(
                    title: strings.profileExpiryReminderSettings,
                    trailingText: '14 days before',
                    onTap: () {
                      // TODO: Open Expiry Reminder Settings
                    },
                    showDivider: false,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // App
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
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      context.read<AppSettingsCubit>().toggleTheme(value);
                    },
                  ),
                  ProfileSwitchTile(
                    title: 'Arabic Language',
                    value: Localizations.localeOf(context).languageCode == 'ar',
                    onChanged: (value) {
                      context.read<AppSettingsCubit>().changeLanguage(value);
                    },
                    showDivider: false,
                  ),
                ],
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}