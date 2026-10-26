import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import 'activity_screen.dart';
import 'home_screen.dart';
import 'nutrition_screen.dart';
import 'workouts_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onNavigate: _go),
      const WorkoutsScreen(),
      const ActivityScreen(),
      const NutritionScreen(),
    ];

    return AppGradient(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: IndexedStack(index: _index, children: pages),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: NavigationBar(
                height: 66,
                backgroundColor: kGlassFill,
                selectedIndex: _index,
                onDestinationSelected: _go,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded, color: AppColors.mintDark),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.fitness_center_outlined),
                    selectedIcon: Icon(Icons.fitness_center, color: AppColors.mintDark),
                    label: 'Workouts',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.insights_outlined),
                    selectedIcon: Icon(Icons.insights, color: AppColors.mintDark),
                    label: 'Activity',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.restaurant_outlined),
                    selectedIcon: Icon(Icons.restaurant, color: AppColors.mintDark),
                    label: 'Nutrition',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
