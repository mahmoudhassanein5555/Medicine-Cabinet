import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/home/presentation/view/home_screen.dart';
import 'package:medicine_cabinet/features/home/presentation/view/widgets/profile_tab_view.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_cubit.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view/screens/medicines_screen.dart';
import 'package:medicine_cabinet/features/medicine/peresentation/view_model/medicine_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:medicine_cabinet/features/profile/presentation/screens/profile_screen.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class CustomBottomNavBar extends StatefulWidget {
  final String? userId;
  final String? householdId;

  const CustomBottomNavBar({super.key, this.userId, this.householdId});

  @override
  State<CustomBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<CustomBottomNavBar> {
  late final String effectiveUserId;
  late final String effectiveHouseholdId;
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    effectiveUserId =
        widget.userId ??
        FirebaseAuth.instance.currentUser?.uid ??
        "FlwarNVYFWM17QKlEnUm";
    effectiveHouseholdId = widget.householdId ?? effectiveUserId;

    _screens = [
      BlocProvider(
        lazy: false,
        create: (_) => getIt<HomeCubit>(),
        child: HomeScreen(
          userId: effectiveUserId,
          householdId: effectiveHouseholdId,
        ),
      ),
      BlocProvider(
        create: (_) => getIt<MedicineCubit>(),
        child: MedicinesScreen(householdId: "household123"),
      ),
      Center(child: Text("Hello"),),
      BlocProvider(create:(_) => getIt<ProfileCubit>(),child: ProfileScreen(), ),
       Center(child: Text('Feed Screen')),
      // ProfileTabView(userId: effectiveUserId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 75,
        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: [
            CurvedNavigationBarItem(
              child: const Icon(Icons.home),
              label: S.of(context).homeNavLabel,
            ),
            CurvedNavigationBarItem(
              child: const Icon(Icons.medical_information),
              label: S.of(context).medicinesNavLabel,
            ),
            CurvedNavigationBarItem(
              child: const Icon(Icons.newspaper),
              label: S.of(context).alertsNavLabel,
            ),
            CurvedNavigationBarItem(
              child: const Icon(Icons.perm_identity),
              label: S.of(context).profileNavLabel,
            ),
          ],
          color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          buttonBackgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          backgroundColor: isDark
              ? AppColors.primaryDarkVariant
              : AppColors.primaryDarkLight,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
      body: IndexedStack(index: _page, children: _screens),
    );
  }
}
