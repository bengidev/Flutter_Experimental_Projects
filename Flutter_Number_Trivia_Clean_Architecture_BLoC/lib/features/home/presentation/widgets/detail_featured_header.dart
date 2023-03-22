import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class DetailFeaturedHeader extends HookWidget {
  const DetailFeaturedHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: $styles.insets.xs,
              right: $styles.insets.xs,
            ),
            child: AppText(
              text: ConstantTexts.findOutTrueMeaning,
              textAlign: TextAlign.right,
              textStyle: $styles.textStyle.h3,
              maxLines: 10,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all($styles.insets.sm),
          alignment: Alignment.topLeft,
          child: Image.asset(
            ConstantAssets.mentalHealthPsychologyNight,
            cacheWidth: (context.widthPx * 0.9).round(),
            width: context.widthPx * 0.5,
            height: context.widthPx * 0.8,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
