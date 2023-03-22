import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/dependency_injection.dart';

class AppText extends HookWidget {
  final String? text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final int? maxLines;

  const AppText({
    Key? key,
    this.text,
    this.textAlign,
    this.textStyle,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text ?? "Default Text",
      textAlign: textAlign ?? TextAlign.center,
      style: textStyle ?? $styles.textStyle.body4,
      maxLines: maxLines ?? 4,
      overflow: TextOverflow.ellipsis,
    );
  }
}
