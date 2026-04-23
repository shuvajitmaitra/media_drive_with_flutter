import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/widgets/app_shell.dart';
import 'package:media_drive_with_flutter/screens/contact_screen.dart';
import 'package:media_drive_with_flutter/screens/home_screen.dart';
import 'package:media_drive_with_flutter/screens/library_screen.dart';
import 'package:media_drive_with_flutter/screens/media_screen.dart';
import 'package:media_drive_with_flutter/screens/portfolio_screen.dart';
import 'package:media_drive_with_flutter/screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppShell(
          location: state.uri.path,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
          routes: [
            GoRoute(
              path: 'details/:name',
              builder: (context, state) => ProfileScreen(
                name: state.pathParameters['name'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/portfolio',
          builder: (context, state) => const PortfolioScreen(),
        ),
        GoRoute(
          path: '/library/:test',
          builder: (context, state) =>
              LibraryScreen(test: state.pathParameters['test']),
          routes: [
            GoRoute(
              path: 'contact',
              builder: (context, state) => ContactScreen(
                params: state.pathParameters['test'],
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/media',
          builder: (context, state) => const MediaScreen(),
        ),
      ],
    ),
  ],
);
