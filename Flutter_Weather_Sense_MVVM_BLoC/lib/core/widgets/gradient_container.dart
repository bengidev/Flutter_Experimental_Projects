import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GradientContainer extends HookWidget {
  final List<Color> colors;
  final List<double> stops;
  final double? width;
  final double? height;
  final Widget? child;
  final Alignment? begin;
  final Alignment? end;
  final Alignment? alignment;
  final BlendMode? blendMode;
  final BorderRadius? borderRadius;

  const GradientContainer({
    super.key,
    required this.colors,
    required this.stops,
    this.width,
    this.height,
    this.child,
    this.begin,
    this.end,
    this.alignment,
    this.blendMode,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.centerLeft,
          end: end ?? Alignment.centerRight,
          colors: colors,
          stops: stops,
        ),
        backgroundBlendMode: blendMode,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class HorizontalGradientContainer extends GradientContainer {
  const HorizontalGradientContainer({
    super.key,
    required super.colors,
    required super.stops,
    super.width,
    super.height,
    super.child,
    super.alignment,
    super.blendMode,
    super.borderRadius,
  });
}

class VerticalGradientContainer extends GradientContainer {
  const VerticalGradientContainer({
    super.key,
    required super.colors,
    required super.stops,
    super.width,
    super.height,
    super.child,
    super.alignment,
    super.blendMode,
    super.borderRadius,
  }) : super(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
}
