import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/router/config/tab_config.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;

  const AppShell({required this.location, required this.child, super.key});

  AppTab get _activeTab => routeOwnership[location] ?? AppTab.home;

  @override
  Widget build(BuildContext context) {
    final activeTab = _activeTab;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: AppTab.values.indexOf(activeTab),
        onDestinationSelected: (value) {
          final tab = AppTab.values[value];
          context.go(tabRootRoutes[tab]!);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border),
            label: 'Skills',
            selectedIcon: Icon(Icons.star),
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            label: 'Experience',
            selectedIcon: Icon(Icons.work),
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            label: 'Projects',
            selectedIcon: Icon(Icons.folder),
          ),
          NavigationDestination(
            icon: Icon(Icons.mail_outline),
            label: 'Contact',
            selectedIcon: Icon(Icons.mail),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
            selectedIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
