class AppRoutePaths {
  const AppRoutePaths._();

  static const home = '/';
  static const profile = '/profile';
  static const portfolio = '/portfolio';
  static const library = '/library';
  static const contact = '/library/contact';
  static const media = '/media';

  static String profileDetails(String name) => '$profile/details/$name';
}
