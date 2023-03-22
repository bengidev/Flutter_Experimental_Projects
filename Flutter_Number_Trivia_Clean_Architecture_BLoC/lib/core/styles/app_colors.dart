import 'package:flutter/material.dart';

@immutable
class AppColors {
  /// Common
  final primary = const Color(0xFF095D9E);
  final secondary = const Color(0xFFDD520F);
  final tertiary = const Color(0xFFC5E7FF);
  final neutral = const Color(0xFF8F9193);
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
  final pelorous = const Color(0xFF1F91A9);
  final error = const Color(0xFFFF2D6F);

  /// Color Scheme for Light Theme
  final flexSchemeLight = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0b61a4),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffd2e4ff),
    onPrimaryContainer: Color(0xff001c37),
    secondary: Color(0xff535f70),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffd7e3f8),
    onSecondaryContainer: Color(0xff101c2b),
    tertiary: Color(0xff6b5778),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xfff3daff),
    onTertiaryContainer: Color(0xff251431),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff410002),
    background: Color(0xfff4f6fb),
    onBackground: Color(0xff1a1c1e),
    surface: Color(0xfff4f6fb),
    onSurface: Color(0xff1a1c1e),
    surfaceVariant: Color(0xffd7dde8),
    onSurfaceVariant: Color(0xff43474e),
    outline: Color(0xff73777f),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xff2d3136),
    onInverseSurface: Color(0xfff1f0f4),
    inversePrimary: Color(0xffa0c9ff),
    surfaceTint: Color(0xff0b61a4),
  );

  final flexSchemeDark = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffa0c9ff),
    onPrimary: Color(0xff003259),
    primaryContainer: Color(0xff00497f),
    onPrimaryContainer: Color(0xffd2e4ff),
    secondary: Color(0xffbbc7db),
    onSecondary: Color(0xff253141),
    secondaryContainer: Color(0xff3c4858),
    onSecondaryContainer: Color(0xffd7e3f8),
    tertiary: Color(0xffd7bde4),
    onTertiary: Color(0xff3b2947),
    tertiaryContainer: Color(0xff533f5f),
    onTertiaryContainer: Color(0xfff3daff),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffb4ab),
    background: Color(0xff21262b),
    onBackground: Color(0xffe3e2e6),
    surface: Color(0xff21262b),
    onSurface: Color(0xffe3e2e6),
    surfaceVariant: Color(0xff484e58),
    onSurfaceVariant: Color(0xffc3c6cf),
    outline: Color(0xff8d9199),
    shadow: Color(0xff000000),
    inverseSurface: Color(0xffdfe0e7),
    onInverseSurface: Color(0xff2f3033),
    inversePrimary: Color(0xff0b61a4),
    surfaceTint: Color(0xffa0c9ff),
  );
}
