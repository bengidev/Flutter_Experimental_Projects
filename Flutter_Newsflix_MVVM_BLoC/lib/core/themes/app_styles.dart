import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:newsflix/core/core_barrel.dart';

final class AppStyles {
  /// The current theme colors for the app.
  final AppColors colors = AppColors();

  /// Scaling factor values based on different screen size.
  late final double scale;

  /// Padding and margin values with scaling factors.
  late final _Insets insets = _Insets(scale: scale);

  AppStyles({Size? screenSize}) {
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;

    if (screenSize == null) {
      scale = 1;
      return;
    }

    final shortestSide = screenSize.shortestSide;
    switch (shortestSide) {
      case > tabletXl:
        scale = 1.25;
      case > tabletLg:
        scale = 1.15;
      case > tabletSm:
        scale = 1;
      case > phoneLg:
        scale = .9; // phone
      default:
        scale = .85; // small phone
    }

    debugPrint('AppStyles screenSize=$screenSize, scale=$scale');
  }
}

final class _Insets {
  final double _scale;

  _Insets({required double scale}) : _scale = scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}
