import 'package:portfolio/router/config/routes_name.dart';

enum AppTab { home, skills, experiences, contact, profile }

//Main Tab
const Map<AppTab, String> tabRootRoutes = {
  AppTab.home: RoutesName.home,
  AppTab.skills: RoutesName.skills,
  AppTab.experiences: RoutesName.experiences,
  AppTab.contact: RoutesName.contact,
  AppTab.profile: RoutesName.profile,
};

//Highlighted Tab
const Map<String, AppTab> routeOwnership = {
  RoutesName.home: AppTab.home,
  RoutesName.skills: AppTab.skills,
  RoutesName.experiences: AppTab.experiences,
  RoutesName.contact: AppTab.contact,
  RoutesName.profile: AppTab.profile,
};
