import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color moss = Color(0xFF183A2D);
  static const Color fern = Color(0xFF2F6B4F);
  static const Color sage = Color(0xFFDDE8D5);
  static const Color cream = Color(0xFFF4F6F0);
  static const Color amber = Color(0xFFF2B35B);
  static const Color ink = Color(0xFF1E2A22);

  static ThemeData get lightTheme => _buildTheme(
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: cream,
    cardColor: Colors.white,
    dividerColor: const Color(0xFFE4E9E1),
    colors: AppColors.light,
  );

  static ThemeData get darkTheme => _buildTheme(
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: const Color(0xFF111713),
    cardColor: const Color(0xFF1B231E),
    dividerColor: const Color(0xFF2F3933),
    colors: AppColors.dark,
  );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: moss,
    onPrimary: Colors.white,
    secondary: amber,
    onSecondary: ink,
    error: Color(0xFFB3261E),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: ink,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: sage,
    onPrimary: ink,
    secondary: amber,
    onSecondary: ink,
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    surface: Color(0xFF1B231E),
    onSurface: Color(0xFFF1F4EE),
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color cardColor,
    required Color dividerColor,
    required AppColors colors,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      extensions: <ThemeExtension<dynamic>>[colors],
      textTheme: Typography.blackMountainView.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: colors.softSurface,
          foregroundColor: colors.iconAccent,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
    );
  }
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.heroStart,
    required this.heroEnd,
    required this.softSurface,
    required this.bodyMuted,
    required this.shadowColor,
    required this.iconAccent,
  });

  final Color heroStart;
  final Color heroEnd;
  final Color softSurface;
  final Color bodyMuted;
  final Color shadowColor;
  final Color iconAccent;

  static const AppColors light = AppColors(
    heroStart: AppTheme.moss,
    heroEnd: AppTheme.fern,
    softSurface: AppTheme.sage,
    bodyMuted: Color(0xFF55635A),
    shadowColor: Color(0x14000000),
    iconAccent: AppTheme.moss,
  );

  static const AppColors dark = AppColors(
    heroStart: AppTheme.moss,
    heroEnd: Color(0xFF4D8A6B),
    softSurface: Color(0xFF233229),
    bodyMuted: Color(0xFFB7C3BA),
    shadowColor: Colors.transparent,
    iconAccent: AppTheme.sage,
  );

  @override
  AppColors copyWith({
    Color? heroStart,
    Color? heroEnd,
    Color? softSurface,
    Color? bodyMuted,
    Color? shadowColor,
    Color? iconAccent,
  }) {
    return AppColors(
      heroStart: heroStart ?? this.heroStart,
      heroEnd: heroEnd ?? this.heroEnd,
      softSurface: softSurface ?? this.softSurface,
      bodyMuted: bodyMuted ?? this.bodyMuted,
      shadowColor: shadowColor ?? this.shadowColor,
      iconAccent: iconAccent ?? this.iconAccent,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      heroStart: Color.lerp(heroStart, other.heroStart, t) ?? heroStart,
      heroEnd: Color.lerp(heroEnd, other.heroEnd, t) ?? heroEnd,
      softSurface: Color.lerp(softSurface, other.softSurface, t) ?? softSurface,
      bodyMuted: Color.lerp(bodyMuted, other.bodyMuted, t) ?? bodyMuted,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      iconAccent: Color.lerp(iconAccent, other.iconAccent, t) ?? iconAccent,
    );
  }
}

class AppThemeController extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  const AppThemeController({
    required ValueNotifier<ThemeMode> notifier,
    required super.child,
    super.key,
  }) : super(notifier: notifier);

  static ValueNotifier<ThemeMode> notifierOf(BuildContext context) {
    final controller = context
        .dependOnInheritedWidgetOfExactType<AppThemeController>();
    assert(controller != null, 'AppThemeController not found in widget tree.');
    return controller!.notifier!;
  }
}

extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  ThemeMode get themeMode => AppThemeController.notifierOf(this).value;

  void toggleTheme() {
    final notifier = AppThemeController.notifierOf(this);
    notifier.value = notifier.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
  }
}
