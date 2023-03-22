import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class HomeFeaturedTrivia extends HookWidget {
  final String number;
  final void Function()? onPressed;

  const HomeFeaturedTrivia({
    super.key,
    this.number = "Please Wait...",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx,
      height: context.heightPx * 0.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 5,
            child: Container(
              width: context.widthPx * 0.95,
              height: context.heightPx * 0.12,
              decoration: BoxDecoration(
                border: Border.all(
                  color: $styles.colors.offBlack,
                ),
                borderRadius: BorderRadius.circular($styles.corners.sm),
                boxShadow: kElevationToShadow[4],
                color: $styles.colors.tertiary,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: Container(
              width: context.widthPx * 0.6,
              height: context.heightPx * 0.05,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: $styles.insets.sm),
              child: AppText(
                text: ConstantTexts.featuredTrivia,
                textAlign: TextAlign.center,
                textStyle: $styles.textStyle.title1Bold,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 60,
            child: Container(
              alignment: Alignment.center,
              width: context.widthPx * 0.6,
              height: context.heightPx * 0.05,
              child: AppText(
                text: ConstantTexts.randomTriviaNumber,
                textStyle: $styles.textStyle.h3Bold,
              ),
            ),
          ),
          Positioned(
            left: 35,
            bottom: 38,
            child: Container(
              alignment: Alignment.center,
              width: context.widthPx * 0.4,
              height: context.heightPx * 0.05,
              child: AppText(
                text: ConstantTexts.generatedForYou,
                textStyle: $styles.textStyle.body4,
              ),
            ),
          ),
          Positioned(
            right: (!number.contains('Please Wait')) ? 130 : 110,
            bottom: 38,
            child: Container(
              alignment: Alignment.center,
              width: context.widthPx * 0.3,
              height: context.heightPx * 0.05,
              child: AppText(
                text: number,
                textStyle: $styles.textStyle.body4,
              ),
            ),
          ),
          Positioned(
            left: 45,
            bottom: 2,
            child: AppElevatedButton(
              width: context.widthPx * 0.2,
              height: context.heightPx * 0.02,
              text: "See details",
              onPressed: onPressed,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 10,
            child: Image.asset(
              ConstantAssets.drawKitLarry3,
              cacheWidth: (context.widthPx * 0.8).round(),
              width: context.widthPx * 0.35,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
