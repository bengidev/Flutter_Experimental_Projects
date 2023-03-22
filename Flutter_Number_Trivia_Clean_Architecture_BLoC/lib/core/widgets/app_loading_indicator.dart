import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';

class AppLoadingIndicator extends HookWidget {
  const AppLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular($styles.corners.sm),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(text: "Loading", textStyle: $styles.textStyle.h3Bold),
          Gap($styles.insets.sm),
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
