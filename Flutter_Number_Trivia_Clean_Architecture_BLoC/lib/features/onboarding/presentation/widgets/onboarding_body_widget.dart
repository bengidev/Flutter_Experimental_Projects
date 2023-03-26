import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingBodyWidget extends HookWidget {
  const OnboardingBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all($styles.insets.sm),
          width: context.widthPx * 0.9,
          child: AppText(
            text: ConstantTexts.everyNumber,
            textStyle: $styles.textStyle.h1,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
        Container(
          padding: EdgeInsets.all($styles.insets.xs),
          width: context.widthPx * 0.9,
          child: AppText(
            text: ConstantTexts.weAreVeryLucky,
            textStyle: $styles.textStyle.body1,
            textAlign: TextAlign.center,
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
