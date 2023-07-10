import 'package:flutter/material.dart';

final class AppColors {
  static const primary = Color(0xFFF7BF4F);
  static const secondary = Color(0xFFFFCF00);
  static const tertiary = Color(0xFF120E00);
  static const accentGray = Color(0xFFF5F5F5);
  static const customGreen = Color(0xFF38493F);
  static const cream = Color(0xFFFCF8E8);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF7C5800),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDEA6),
    onPrimaryContainer: Color(0xFF271900),
    secondary: Color(0xFF735C00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFE084),
    onSecondaryContainer: Color(0xFF231B00),
    tertiary: Color(0xFF6D5E00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFCE265),
    onTertiaryContainer: Color(0xFF211B00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1E1B16),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1E1B16),
    surfaceVariant: Color(0xFFEEE1CF),
    onSurfaceVariant: Color(0xFF4E4639),
    outline: Color(0xFF807667),
    onInverseSurface: Color(0xFFF8EFE7),
    inverseSurface: Color(0xFF34302A),
    inversePrimary: Color(0xFFF7BD48),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF7C5800),
    outlineVariant: Color(0xFFD1C5B4),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF7BD48),
    onPrimary: Color(0xFF412D00),
    primaryContainer: Color(0xFF5E4200),
    onPrimaryContainer: Color(0xFFFFDEA6),
    secondary: Color(0xFFEFC200),
    onSecondary: Color(0xFF3C2F00),
    secondaryContainer: Color(0xFF574500),
    onSecondaryContainer: Color(0xFFFFE084),
    tertiary: Color(0xFFDFC64C),
    onTertiary: Color(0xFF393000),
    tertiaryContainer: Color(0xFF524600),
    onTertiaryContainer: Color(0xFFFCE265),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1E1B16),
    onBackground: Color(0xFFE9E1D9),
    surface: Color(0xFF1E1B16),
    onSurface: Color(0xFFE9E1D9),
    surfaceVariant: Color(0xFF4E4639),
    onSurfaceVariant: Color(0xFFD1C5B4),
    outline: Color(0xFF9A8F80),
    onInverseSurface: Color(0xFF1E1B16),
    inverseSurface: Color(0xFFE9E1D9),
    inversePrimary: Color(0xFF7C5800),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFF7BD48),
    outlineVariant: Color(0xFF4E4639),
    scrim: Color(0xFF000000),
  );
}
