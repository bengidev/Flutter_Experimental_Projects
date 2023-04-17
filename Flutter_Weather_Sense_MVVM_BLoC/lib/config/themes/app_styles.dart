import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppStyles {
  AppStyles({
    Size? screenSize,
  }) {
    if (screenSize == null) {
      scale = 1;
      return;
    }
    final shortestSide = screenSize.shortestSide;
    const tabletXl = 1000;
    const tabletLg = 800;
    const tabletSm = 600;
    const phoneLg = 400;
    if (shortestSide > tabletXl) {
      scale = 1.25;
    } else if (shortestSide > tabletLg) {
      scale = 1.15;
    } else if (shortestSide > tabletSm) {
      scale = 1;
    } else if (shortestSide > phoneLg) {
      scale = .9; // phone
    } else {
      scale = .85; // small phone
    }
    debugPrint('screenSize=$screenSize, scale=$scale');
  }

  late final double scale;

  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  /// Text styles
  late final _TextStyles textStyle = _TextStyles(scale: scale);

  /// Animation Durations
  final _Times times = _Times();

  /// Shared sizes
  late final _Sizes sizes = _Sizes();
}

@immutable
class _TextStyles {
  final double _scale;

  final titleFont = GoogleFonts.lustria();
  final contentFont = GoogleFonts.openSans();

  _TextStyles({required double scale}) : _scale = scale;

  late final TextStyle dropCase =
      _createFont(contentFont, sizePx: 56, heightPx: 20);

  late final TextStyle wonderTitle =
      _createFont(titleFont, sizePx: 64, heightPx: 56);

  late final TextStyle h1 = _createFont(titleFont, sizePx: 64, heightPx: 62);
  late final TextStyle h2 = _createFont(titleFont, sizePx: 32, heightPx: 46);
  late final TextStyle h3 = _createFont(titleFont, sizePx: 24, heightPx: 36);
  late final TextStyle h3Bold =
      _createFont(titleFont, sizePx: 24, heightPx: 36, weight: FontWeight.w600);
  late final TextStyle h4 =
      _createFont(titleFont, sizePx: 21, heightPx: 23, spacingPc: 5);
  late final TextStyle h4Bold = _createFont(
    titleFont,
    sizePx: 21,
    heightPx: 23,
    spacingPc: 5,
    weight: FontWeight.w600,
  );
  late final TextStyle h5 =
      _createFont(titleFont, sizePx: 18, heightPx: 10, spacingPc: 5);
  late final TextStyle h5Bold = _createFont(
    titleFont,
    sizePx: 18,
    heightPx: 10,
    spacingPc: 5,
    weight: FontWeight.w600,
  );

  late final TextStyle title1 =
      _createFont(titleFont, sizePx: 16, heightPx: 26, spacingPc: 5);
  late final TextStyle title1Bold = _createFont(
    titleFont,
    sizePx: 16,
    heightPx: 26,
    spacingPc: 5,
    weight: FontWeight.w600,
  );
  late final TextStyle title2 =
      _createFont(titleFont, sizePx: 14, heightPx: 16.38);
  late final TextStyle title2Bold = _createFont(
    titleFont,
    sizePx: 14,
    heightPx: 16.38,
    weight: FontWeight.w600,
  );

  late final TextStyle body1 =
      _createFont(contentFont, sizePx: 20, heightPx: 32);
  late final TextStyle body1Bold = _createFont(
    contentFont,
    sizePx: 20,
    heightPx: 32,
    weight: FontWeight.w600,
  );

  late final TextStyle body2 =
      _createFont(contentFont, sizePx: 19, heightPx: 30.5);
  late final TextStyle body2Bold = _createFont(
    contentFont,
    sizePx: 19,
    heightPx: 30.5,
    weight: FontWeight.w600,
  );

  late final TextStyle body3 =
      _createFont(contentFont, sizePx: 18, heightPx: 29);
  late final TextStyle body3Bold = _createFont(
    contentFont,
    sizePx: 18,
    heightPx: 29,
    weight: FontWeight.w600,
  );

  late final TextStyle body4 =
      _createFont(contentFont, sizePx: 17, heightPx: 27.5);
  late final TextStyle body4Bold = _createFont(
    contentFont,
    sizePx: 17,
    heightPx: 27.5,
    weight: FontWeight.w600,
  );

  late final TextStyle body5 =
      _createFont(contentFont, sizePx: 16, heightPx: 26);
  late final TextStyle body5Bold = _createFont(
    contentFont,
    sizePx: 16,
    heightPx: 26,
    weight: FontWeight.w600,
  );

  late final TextStyle bodySmall =
      _createFont(contentFont, sizePx: 14, heightPx: 23);
  late final TextStyle bodySmallBold = _createFont(
    contentFont,
    sizePx: 14,
    heightPx: 23,
    weight: FontWeight.w600,
  );

  late final TextStyle quote1 = _createFont(
    contentFont,
    sizePx: 32,
    heightPx: 40,
    weight: FontWeight.w600,
    spacingPc: -3,
  );
  late final TextStyle quote2 = _createFont(
    contentFont,
    sizePx: 21,
    heightPx: 32,
    weight: FontWeight.w400,
  );
  late final TextStyle quote2Sub =
      _createFont(body4, sizePx: 16, heightPx: 40, weight: FontWeight.w400);

  late final TextStyle caption = _createFont(
    contentFont,
    sizePx: 14,
    heightPx: 20,
    weight: FontWeight.w500,
  ).copyWith(fontStyle: FontStyle.italic);

  late final TextStyle callout = _createFont(
    contentFont,
    sizePx: 16,
    heightPx: 26,
    weight: FontWeight.w600,
  ).copyWith(fontStyle: FontStyle.italic);

  late final TextStyle button = _createFont(
    contentFont,
    sizePx: 14,
    weight: FontWeight.w600,
    spacingPc: 2,
    heightPx: 14,
  );

  TextStyle _createFont(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    sizePx *= _scale;
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      fontSize: sizePx,
      fontWeight: weight,
      letterSpacing:
          spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
    );
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

// TODO: add, @immutable when design is solidified
class _Sizes {
  double get maxContentWidth1 => 800;

  double get maxContentWidth2 => 600;

  double get maxContentWidth3 => 500;
  final Size minAppSize = const Size(380, 675);
}

@immutable
class _Insets {
  _Insets(this._scale);

  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
      color: Colors.black.withOpacity(.25),
      offset: const Offset(0.0, 2.0),
      blurRadius: 4.0,
    ),
  ];
  final text = [
    Shadow(
      color: Colors.black.withOpacity(.6),
      offset: const Offset(0.0, 2.0),
      blurRadius: 2.0,
    ),
  ];
  final textStrong = [
    Shadow(
      color: Colors.black.withOpacity(.6),
      offset: const Offset(0.0, 4.0),
      blurRadius: 6.0,
    ),
  ];
}
