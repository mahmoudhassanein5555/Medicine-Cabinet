import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_keys.dart';
import 'package:medicine_cabinet/core/dialogs/app_dialogs.dart';
import 'package:medicine_cabinet/core/dialogs/app_toasts.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/core/settings/app_settings_cubit.dart';
import 'package:medicine_cabinet/core/utils/household_local_data_source.dart';
import 'package:medicine_cabinet/core/utils/shared_prefs_local_data_source.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_state.dart';
import 'package:medicine_cabinet/features/auth/presentation/views/login_screen.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/household_members_screen.dart';
import 'package:medicine_cabinet/features/household/presentation/view/view/household_screen.dart';
import 'package:medicine_cabinet/features/profile/domain/entities/profile_entity.dart';
import 'package:medicine_cabinet/features/profile/presentation/view/personal_information_screen.dart';
import 'package:medicine_cabinet/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_header.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_language_tile.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_option_tile.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_section.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_switch_tile.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class ProfileContentView extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileContentView({super.key, required this.profile});

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
              onPressed: () => Navigator.pop(context),
              child: Text(strings.commonClose),
            ),
          ],
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),

            // Profile Header
            ProfileHeader(profile: profile),

            SizedBox(height: 24.h),

            // Account Section
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
                    final householdId =
                        getIt<HouseholdLocalDataSource>().getHouseholdId();
                    final userId =
                        getIt<CacheHelper>().getData(key: AppKeys.userId)
                            as String? ??
                        FirebaseAuth.instance.currentUser?.uid ??
                        '';

                    if (householdId != null && householdId.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HouseholdMembersScreen(
                            householdId: householdId,
                            userId: userId,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HouseholdScreen(
                            userId: userId,
                          ),
                        ),
                      );
                    }
                  },
                  showDivider: false,
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // App Section
            ProfileSection(
              title: strings.profileAppSection,
              children: [
                ProfileSwitchTile(
                  title: strings.profileDarkMode,
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    context.read<AppSettingsCubit>().toggleTheme(value);
                  },
                ),
                const ProfileLanguageTile(showDivider: true),
                ProfileOptionTile(
                  title: strings.profileAppVersion,
                  trailingText: '1.0.0',
                  showDivider: false,
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Information Section
            ProfileSection(
              title: strings.profileInformationSection,
              children: [
                ProfileOptionTile(
                  title: strings.profileAbout,
                  onTap: () => _showAboutDialog(context),
                  showDivider: false,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Logout
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
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                return Material(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  clipBehavior: Clip.antiAlias,
                  child: ProfileOptionTile(
                    title: strings.profileLogout,
                    color: Colors.red,
                    onTap: () => _showLogoutDialog(context),
                    showDivider: false,
                  ),
                );
              },
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
