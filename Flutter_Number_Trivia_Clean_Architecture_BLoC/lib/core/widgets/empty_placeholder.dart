import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/dependency_injection.dart';

import 'app_elevated_button.dart';

class EmptyPlaceholder extends HookWidget {
  final String? message;
  final Function()? onPressed;

  const EmptyPlaceholder({
    Key? key,
    required this.message,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all($styles.insets.sm),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message ?? "Default Message",
              style: $styles.textStyle.body4Bold,
            ),
            const Gap(20),
            AppElevatedButton(
              text: "Go To Login",
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
