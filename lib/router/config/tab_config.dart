import 'package:portfolio/router/config/routes_name.dart';

enum AppTab { home, skills, experiences, projects, contact, profile }

//Main Tab
const Map<AppTab, String> tabRootRoutes = {
  AppTab.home: RoutesName.home,
  AppTab.skills: RoutesName.skills,
  AppTab.experiences: RoutesName.experiences,
  AppTab.projects: RoutesName.projects,
  AppTab.contact: RoutesName.contact,
  AppTab.profile: RoutesName.profile,
};

//Highlighted Tab
const Map<String, AppTab> routeOwnership = {
  RoutesName.home: AppTab.home,
  RoutesName.skills: AppTab.skills,
  RoutesName.experiences: AppTab.experiences,
  RoutesName.projects: AppTab.projects,
  RoutesName.contact: AppTab.contact,
  RoutesName.profile: AppTab.profile,
};
