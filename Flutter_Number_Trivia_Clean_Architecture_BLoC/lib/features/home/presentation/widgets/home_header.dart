import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class HomeHeader extends HookWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPx,
      height: context.heightPx * 0.14,
      decoration: BoxDecoration(
        color: $styles.colors.offWhite,
        border: Border.all(color: $styles.colors.offBlack),
      ),
      child: Row(
        children: [
          Image.asset(
            ConstantAssets.drawKitLarry5,
            cacheWidth: (context.widthPx * 0.8).round(),
            width: context.widthPx * 0.3,
            fit: BoxFit.cover,
          ),
          Container(
            width: context.widthPx * 0.65,
            height: context.heightPx * 0.12,
            alignment: Alignment.center,
            child: AppText(
              text: ConstantTexts.firstQuote,
              textAlign: TextAlign.center,
              textStyle: $styles.textStyle.quote1,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
