import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Custom Text button based on [TextButton].
/// [text] - text to display on the button.
/// [style] - text style for styling the text on button.
/// [onPressed] - callback to be called when the button is pressed.
class AppTextButton extends HookWidget {
  final String? text;
  final Function()? onPressed;
  final TextStyle? style;

  const AppTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text ?? "Default Text",
        style: style,
      ),
    );
  }
}
