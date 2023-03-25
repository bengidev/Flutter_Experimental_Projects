import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';

class DetailFeaturedCard extends HookWidget {
  final String? number;
  final String? triviaDescription;

  const DetailFeaturedCard({
    super.key,
    required this.number,
    required this.triviaDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all($styles.insets.xs),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadiusDirectional.circular($styles.corners.xs),
                side: BorderSide(color: $styles.colors.offBlack),
              ),
              elevation: 5,
              color: $styles.colors.offWhite,
              child: Padding(
                padding: EdgeInsets.all($styles.insets.xs),
                child: SeparatedColumn(
                  separatorBuilder: () => Gap($styles.insets.xs),
                  children: [
                    Container(
                      padding: EdgeInsets.all($styles.insets.xs),
                      child: AppText(
                        text: "The Meaning of Your Number: $number",
                        textAlign: TextAlign.justify,
                        textStyle: $styles.textStyle.h4Bold,
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all($styles.insets.xs),
                      child: AppText(
                        text: "$triviaDescription",
                        textAlign: TextAlign.justify,
                        textStyle: $styles.textStyle.body1,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
