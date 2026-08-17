import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';
import 'package:medicine_cabinet/core/di/service_locator.dart';
import 'package:medicine_cabinet/features/home/presentation/view/home_screen.dart';
import 'package:medicine_cabinet/features/home/presentation/view_model/home_cubit.dart';
import 'package:medicine_cabinet/generated/l10n.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<CustomBottomNavBar> {
  final userId = "FlwarNVYFWM17QKlEnUm";
  final householdId = "household123";
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        lazy: false,
        create: (_) => getIt<HomeCubit>(),
        child: HomeScreen(userId: userId, householdId: householdId),
      ),
      const Center(child: Text('Search Screen')),
      const Center(child: Text('Chat Screen')),
      const Center(child: Text('Feed Screen')),
      const Center(child: Text('Personal Screen')),
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
              child: const Icon(Icons.search),
              label: S.of(context).searchNavLabel,
            ),
            CurvedNavigationBarItem(
              child: const Icon(Icons.chat_bubble_outline),
              label: S.of(context).chatNavLabel,
            ),
            CurvedNavigationBarItem(
              child: const Icon(Icons.newspaper),
              label: S.of(context).feedNavLabel,
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
