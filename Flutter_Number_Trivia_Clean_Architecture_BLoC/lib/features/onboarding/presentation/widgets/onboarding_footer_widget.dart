import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingFooterWidget extends HookWidget {
  final void Function()? onPressed;

  const OnboardingFooterWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx * 0.8,
      height: context.heightPx * 0.05,
      child: AppElevatedButton(
        text: "Get Started",
        onPressed: onPressed,
      ),
    );
  }
}
