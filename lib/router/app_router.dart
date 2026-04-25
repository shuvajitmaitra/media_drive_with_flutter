import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/router/app_shell.dart';
import 'package:media_drive_with_flutter/router/config/routes_name.dart';
import 'package:media_drive_with_flutter/screens/home/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: RoutesName.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: RoutesName.home,
          builder: (context, state) => HomeScreen(),
        ),
      ],
    ),
  ],
);
