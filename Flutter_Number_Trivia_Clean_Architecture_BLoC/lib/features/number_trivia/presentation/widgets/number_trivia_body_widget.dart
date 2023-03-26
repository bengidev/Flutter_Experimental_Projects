import 'package:flextras/flextras.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class NumberTriviaBodyWidget extends HookWidget {
  final Function(String string)? onStringCallback;

  const NumberTriviaBodyWidget({
    super.key,
    this.onStringCallback,
  });

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();

    return SizedBox(
      width: context.widthPx,
      height: context.heightPx * 0.18,
      child: PaddedColumn(
        padding: EdgeInsets.all($styles.insets.sm),
        children: [
          Container(
            padding: EdgeInsets.all($styles.insets.sm),
            width: context.widthPx * 0.9,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular($styles.corners.md),
            ),
            child: SeparatedColumn(
              separatorBuilder: () => Gap($styles.insets.sm),
              children: [
                Row(
                  children: [
                    const Icon(FluentIcons.book_number_24_regular),
                    Gap($styles.insets.xs),
                    AppText(
                      text: "Number",
                      textStyle: $styles.textStyle.body4Bold,
                    ),
                  ],
                ),
                TextField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular($styles.corners.sm),
                    ),
                    hintText: "Input a number",
                  ),
                  onChanged: (value) {
                    onStringCallback?.call(value);
                  },
                  onSubmitted: (value) {
                    onStringCallback?.call(value);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
