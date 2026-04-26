import 'package:go_router/go_router.dart';
import 'package:portfolio/router/app_shell.dart';
import 'package:portfolio/router/config/routes_name.dart';
import 'package:portfolio/screens/contact/contact_screen.dart';
import 'package:portfolio/screens/experiences/experiences_screen.dart';
import 'package:portfolio/screens/home/home_screen.dart';
import 'package:portfolio/screens/profile/profile_screen.dart';
import 'package:portfolio/screens/projects/projects_screen.dart';
import 'package:portfolio/screens/skills/skills_screen.dart';

final appRouter = GoRouter(
  initialLocation: RoutesName.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: RoutesName.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutesName.skills,
          builder: (context, state) => const SkillsScreen(),
        ),
        GoRoute(
          path: RoutesName.experiences,
          builder: (context, state) => const ExperiencesScreen(),
        ),
        GoRoute(
          path: RoutesName.projects,
          builder: (context, state) => const ProjectsScreen(),
        ),
        GoRoute(
          path: RoutesName.contact,
          builder: (context, state) => const ContactScreen(),
        ),
        GoRoute(
          path: RoutesName.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
