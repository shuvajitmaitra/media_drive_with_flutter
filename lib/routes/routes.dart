import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/screens/contact_screen.dart';
import 'package:media_drive_with_flutter/screens/home_screen.dart';
import 'package:media_drive_with_flutter/screens/library_screen.dart';
import 'package:media_drive_with_flutter/screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
      routes: [
        GoRoute(
          path: 'library',
          builder: (context, state) => LibraryScreen(),
          routes: [
            GoRoute(
              path: 'contact',
              builder: (context, state) => ContactScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
