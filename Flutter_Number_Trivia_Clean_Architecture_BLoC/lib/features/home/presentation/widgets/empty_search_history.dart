import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class EmptySearchHistory extends HookWidget {
  const EmptySearchHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.widthPx,
          height: context.heightPx * 0.05,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: $styles.insets.sm),
          child: AppText(
            text: ConstantTexts.yourSearchHistory,
            textAlign: TextAlign.center,
            textStyle: $styles.textStyle.title1Bold,
          ),
        ),
        Container(
          padding: EdgeInsets.all($styles.insets.sm),
          width: context.widthPx * 0.9,
          height: context.heightPx * 0.07,
          decoration: BoxDecoration(
            color: $styles.colors.offWhite,
            border: Border.all(
              color: $styles.colors.offBlack,
            ),
            borderRadius: BorderRadius.circular(
              $styles.corners.sm,
            ),
            boxShadow: kElevationToShadow[4],
          ),
          child: AppText(
            text: "Empty",
            textAlign: TextAlign.center,
            textStyle: $styles.textStyle.body5,
          ),
        ),
      ],
    );
  }
}
