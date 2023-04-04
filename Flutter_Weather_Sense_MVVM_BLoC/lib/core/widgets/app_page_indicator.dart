import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppPageIndicator extends HookWidget {
  final double? width;
  final double? height;
  final PageController controller;
  final int totalPages;
  final void Function(int index)? onDotPressed;
  final Color? baseDotColor;
  final Color? activeDotColor;
  final double? dotSize;
  final double? dotSpacing;
  final double? dotRadius;

  const AppPageIndicator({
    super.key,
    this.width,
    this.height,
    required this.controller,
    required this.totalPages,
    this.onDotPressed,
    this.baseDotColor,
    this.activeDotColor,
    this.dotSize,
    this.dotSpacing,
    this.dotRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: SmoothPageIndicator(
        key: key,
        controller: controller,
        count: totalPages,
        onDotClicked: onDotPressed,
        effect: WormEffect(
          dotColor: baseDotColor ?? $appStyles.colors.greyMedium,
          activeDotColor: activeDotColor ?? $appStyles.colors.primary,
          dotWidth: dotSize ?? 10,
          dotHeight: dotSize ?? 8,
          strokeWidth: (dotSize ?? 10) / 2,
          spacing: dotSpacing ?? 10,
          radius: dotRadius ?? 10,
        ),
      ),
    );
  }
}
