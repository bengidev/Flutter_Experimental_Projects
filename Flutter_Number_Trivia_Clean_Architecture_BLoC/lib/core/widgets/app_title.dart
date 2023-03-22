import 'package:flextras/flextras.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';

class AppTitle extends HookWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($styles.insets.sm),
      child: SeparatedRow(
        separatorBuilder: () => Gap($styles.insets.xs),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FluentIcons.book_number_24_regular,
            size: $styles.insets.lg,
          ),
          AppText(
              text: ConstantTexts.appName, textStyle: $styles.textStyle.h4Bold),
        ],
      ),
    );
  }
}
