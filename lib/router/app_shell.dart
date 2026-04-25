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
        ],
      ),
    );
  }
}
