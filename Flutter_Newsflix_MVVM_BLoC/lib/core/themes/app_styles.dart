import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:newsflix/core/core_barrel.dart';

final class AppStyles {
  final Size? screenSize;
  final AppColors colors = AppColors();
  late final double scale;

  AppStyles({
    this.screenSize,
  }) {
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;

    if (screenSize == null) {
      scale = 1;
      return;
    }

    final shortestSide = screenSize!.shortestSide;
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

    debugPrint('screenSize=$screenSize, scale=$scale');
  }
}
