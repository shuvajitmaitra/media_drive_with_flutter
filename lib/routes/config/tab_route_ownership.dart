enum AppTab {
  home,
  profile,
  portfolio,
}

class TabRouteOwnership {
  const TabRouteOwnership._();

  static const _profileOwnedPrefixes = <String>[
    '/profile',
    '/library',
  ];
  static const _portfolioOwnedPrefixes = <String>[
    '/portfolio',
    '/media',
  ];

  static AppTab tabForLocation(String location) {
    for (final prefix in _profileOwnedPrefixes) {
      if (location.startsWith(prefix)) {
        return AppTab.profile;
      }
    }

    for (final prefix in _portfolioOwnedPrefixes) {
      if (location.startsWith(prefix)) {
        return AppTab.portfolio;
      }
    }

    return AppTab.home;
  }
}
