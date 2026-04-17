import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/config/app_route_paths.dart';
import 'package:media_drive_with_flutter/routes/config/tab_route_ownership.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.location,
    required this.child,
    super.key,
  });

  final String location;
  final Widget child;

  int get _selectedIndex {
    return switch (TabRouteOwnership.tabForLocation(location)) {
      AppTab.home => 0,
      AppTab.profile => 1,
      AppTab.portfolio => 2,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutePaths.home);
            return;
          }

          if (index == 1) {
            context.go(AppRoutePaths.profile);
            return;
          }

          context.go(AppRoutePaths.portfolio);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Portfolio',
          ),
        ],
      ),
    );
  }
}
