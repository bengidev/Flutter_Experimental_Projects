import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/widgets/app_text.dart';
import 'package:number_trivia_project/dependency_injection.dart';

/// Primary button based on [ElevatedButton].
/// [text] - text to display on the button.
/// [style] - text style for styling the text on button.
/// [isLoading] - if true, a loading indicator will be displayed instead of the text.
/// [onPressed] - callback to be called when the button is pressed.
class AppElevatedButton extends HookWidget {
  final double? width;
  final double? height;
  final Function()? onPressed;
  final bool? isLoading;
  final String? text;

  const AppElevatedButton({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    this.isLoading,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular($styles.corners.sm),
        ),
      ),
      onPressed: onPressed,
      child: isLoading ?? false
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              child: AppText(
                text: text,
                textStyle: $styles.textStyle.button,
              ),
            ),
    );
  }
}
