import 'package:flutter/material.dart';

@immutable
class AppColors {
  final primary = const Color(0xFFF8CA56);
  final secondary = const Color(0xFF484F9D);
  final tertiary = const Color(0xFF676DC9);
  final neutral = const Color(0xFF929094);
  final offWhite = const Color(0xFFF8ECE5);
  final caption = const Color(0xFF7D7873);
  final body = const Color(0xFF514F4D);
  final greyStrong = const Color(0xFF272625);
  final greyMedium = const Color(0xFF9D9995);
  final offBlack = const Color(0xFF1E1B18);
  final shadow4 = const Color(0xFFC5C5C5);
  final shadow3 = const Color(0xFFABABAB);
  final shadow2 = const Color(0xFF878787);
  final shadow1 = const Color(0xFF696969);
  final error = const Color(0xFFFF2D6F);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF775A00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDF98),
    onPrimaryContainer: Color(0xFF251A00),
    secondary: Color(0xFF4F56A9),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE0E0FF),
    onSecondaryContainer: Color(0xFF030865),
    tertiary: Color(0xFF4F55AF),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE0E0FF),
    onTertiaryContainer: Color(0xFF02016C),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1E1B16),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1E1B16),
    surfaceVariant: Color(0xFFECE1CF),
    onSurfaceVariant: Color(0xFF4D4639),
    outline: Color(0xFF7E7667),
    onInverseSurface: Color(0xFFF7F0E7),
    inverseSurface: Color(0xFF33302A),
    inversePrimary: Color(0xFFEFC048),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF775A00),
    outlineVariant: Color(0xFFD0C5B4),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFEFC048),
    onPrimary: Color(0xFF3E2E00),
    primaryContainer: Color(0xFF5A4300),
    onPrimaryContainer: Color(0xFFFFDF98),
    secondary: Color(0xFFBEC2FF),
    onSecondary: Color(0xFF1E2578),
    secondaryContainer: Color(0xFF373E90),
    onSecondaryContainer: Color(0xFFE0E0FF),
    tertiary: Color(0xFFBFC2FF),
    onTertiary: Color(0xFF1E237F),
    tertiaryContainer: Color(0xFF373C96),
    onTertiaryContainer: Color(0xFFE0E0FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1E1B16),
    onBackground: Color(0xFFE9E1D9),
    surface: Color(0xFF1E1B16),
    onSurface: Color(0xFFE9E1D9),
    surfaceVariant: Color(0xFF4D4639),
    onSurfaceVariant: Color(0xFFD0C5B4),
    outline: Color(0xFF999080),
    onInverseSurface: Color(0xFF1E1B16),
    inverseSurface: Color(0xFFE9E1D9),
    inversePrimary: Color(0xFF775A00),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFEFC048),
    outlineVariant: Color(0xFF4D4639),
    scrim: Color(0xFF000000),
  );
}
