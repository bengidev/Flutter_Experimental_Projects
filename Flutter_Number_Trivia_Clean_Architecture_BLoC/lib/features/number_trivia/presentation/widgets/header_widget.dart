import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class HeaderWidget extends HookWidget {
  final String? imageString;
  final String? message;

  const HeaderWidget({
    Key? key,
    this.imageString,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstGeneratedColor = Random().nextInt(Colors.accents.length);
    var secondGeneratedColor = Random().nextInt(Colors.accents.length);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular($styles.corners.sm),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular($styles.corners.sm),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.primaries[firstGeneratedColor],
              Colors.primaries[secondGeneratedColor],
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: context.widthPx * 0.7,
              height: context.heightPx * 0.24,
              child: Image.asset(
                cacheWidth: (context.widthPx * 0.7).round(),
                fit: BoxFit.cover,
                ConstantAssets.callWaitingImage,
              ),
            ),
            Container(
              padding: EdgeInsets.all($styles.insets.sm),
              child: AppText(
                text: message,
                textStyle: $styles.textStyle.h3Bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
