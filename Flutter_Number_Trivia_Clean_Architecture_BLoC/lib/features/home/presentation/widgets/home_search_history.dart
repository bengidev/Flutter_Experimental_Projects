import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/home_barrel.dart';
import 'package:sized_context/sized_context.dart';

class HomeSearchHistory extends HookWidget {
  const HomeSearchHistory({super.key});

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
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return SearchHistoryItem(
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
