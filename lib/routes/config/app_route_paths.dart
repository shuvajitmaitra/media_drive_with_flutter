class AppRoutePaths {
  const AppRoutePaths._();

  static const home = '/';
  static const profile = '/profile';
  static const portfolio = '/portfolio';
  static const media = '/media';

  static String library([String test = 'default']) => '/library/$test';
  static String contact([String test = 'default']) => '${library(test)}/contact';
  static String profileDetails(String name) => '$profile/details/$name';
}
