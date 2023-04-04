import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class AppCircleButton extends HookWidget {
  static double defaultSize = 48;
  final double? size;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget? child;
  final void Function() onPressed;

  const AppCircleButton({
    super.key,
    this.size,
    this.backgroundColor,
    this.borderSide,
    this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final sz = size ?? defaultSize;

    return AppButton(
      onPressed: onPressed,
      minimumSize: Size(sz, sz),
      padding: EdgeInsets.zero,
      circular: true,
      backgroundColor: backgroundColor,
      borderSide: borderSide,
      child: child,
    );
  }
}
