import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/dialogs/app_toasts.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/view_model/profile_state.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_content_view.dart';
import 'package:medicine_cabinet/features/profile/presentation/widgets/profile_skeleton.dart';
import 'package:medicine_cabinet/generated/l10n.dart';
import 'package:toastification/toastification.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ProfileCubit>()..loadProfile(),
        ),
        BlocProvider(
          create: (_) => getIt<AuthCubit>(),
        ),
      ],
      child: BlocConsumer<ProfileCubit, ProfileState>(
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
          if (state is ProfileLoading) {
            return const ProfileSkeleton();
          }

          if (state is ProfileLoaded) {
            return ProfileContentView(profile: state.profile);
          }

          if (state is ProfileUpdateSuccess) {
            return ProfileContentView(profile: state.profile);
          }

          if (state is ProfileError) {
            return Scaffold(
              body: Center(child: Text(state.failure.getMessage(context))),
            );
          }

          return const Scaffold(body: Center(child: ProfileSkeleton()));
        },
      ),
    );
  }
}