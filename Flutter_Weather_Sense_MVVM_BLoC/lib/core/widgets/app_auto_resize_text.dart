import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppAutoResizeText extends HookWidget {
  final double? width;
  final double? height;
  final String? text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final double? maxFontSize;
  final double? minFontSize;
  final int? maxLines;

  const AppAutoResizeText({
    super.key,
    this.width,
    this.height,
    this.text,
    this.textAlign,
    this.textStyle,
    this.maxFontSize,
    this.minFontSize,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AutoSizeText(
        text ?? "Default Text",
        textKey: ValueKey(text),
        textAlign: textAlign ?? TextAlign.center,
        style: textStyle,
        maxFontSize: maxFontSize ?? 40,
        minFontSize: minFontSize ?? 10,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
