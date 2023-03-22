import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class SearchHistoryItem extends HookWidget {
  final Function()? onTap;
  final String? number;
  final String? description;

  const SearchHistoryItem({
    super.key,
    required this.onTap,
    this.number,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        $styles.corners.sm,
        0,
        $styles.corners.sm,
        $styles.corners.xs,
      ),
      child: Material(
        color: $styles.colors.tertiary,
        borderRadius: BorderRadius.circular($styles.corners.sm),
        elevation: $styles.corners.xs,
        child: InkWell(
          borderRadius: BorderRadius.circular($styles.corners.sm),
          onTap: onTap,
          child: Container(
            width: context.widthPx,
            height: context.heightPx * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: $styles.colors.offBlack),
              borderRadius: BorderRadius.circular($styles.corners.sm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: context.widthPx * 0.1,
                  child: AppText(
                    text: number ?? "17",
                    textStyle: $styles.textStyle.quote1,
                  ),
                ),
                SizedBox(
                  width: context.widthPx * 0.6,
                  child: AppText(
                    text: description ?? "Default Description",
                    textStyle: $styles.textStyle.body5,
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                  ),
                ),
                const Icon(FluentIcons.arrow_step_in_right_28_regular),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
