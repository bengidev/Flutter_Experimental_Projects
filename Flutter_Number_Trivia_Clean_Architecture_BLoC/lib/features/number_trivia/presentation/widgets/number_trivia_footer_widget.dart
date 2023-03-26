import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class NumberTriviaFooterWidget extends HookWidget {
  final void Function()? onSearchCallback;
  final void Function()? onRandomCallback;

  const NumberTriviaFooterWidget({
    super.key,
    this.onSearchCallback,
    this.onRandomCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx,
      height: context.heightPx * 0.14,
      child: SeparatedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        separatorBuilder: () => Gap($styles.insets.sm),
        children: [
          AppElevatedButton(
            key: const ValueKey('firstButton'),
            width: context.widthPx * 0.7,
            height: context.heightPx * 0.05,
            text: "Search",
            onPressed: onSearchCallback,
          ),
          AppElevatedButton(
            key: const ValueKey('secondButton'),
            width: context.widthPx * 0.7,
            height: context.heightPx * 0.05,
            text: "Get random trivia number",
            onPressed: onRandomCallback,
          ),
        ],
      ),
    );
  }
}
