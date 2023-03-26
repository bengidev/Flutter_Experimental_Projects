import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingHeaderWidget extends HookWidget {
  const OnboardingHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: $styles.insets.xxl),
      width: context.widthPx,
      height: context.heightPx * 0.35,
      child: Image.asset(
        ConstantAssets.drawKitEcologyAndEnvironment,
        width: context.widthPx * 0.9,
        height: context.heightPx * 0.3,
        cacheWidth: (context.widthPx * 0.9).round(),
        fit: BoxFit.contain,
      ),
    );
  }
}
