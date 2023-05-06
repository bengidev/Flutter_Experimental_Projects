import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/generated/assets.dart';

class HomeLocationMap extends StatelessWidget {
  /// Describe the current location based on
  /// [TextFormField] input value.
  final String? locationText;

  /// Show the current location with the form
  /// of a Map. You can change this [Widget]
  /// into another form which are related.
  final String? locationMap;

  const HomeLocationMap({
    super.key,
    this.locationText,
    this.locationMap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: $styles.insets.md,
              right: $styles.insets.md,
            ),
            child: Column(
              children: [
                AppAutoResizeText(
                  alignment: Alignment.centerLeft,
                  text: locationText ?? "LONDON, ",
                  textAlign: TextAlign.left,
                  textStyle: $styles.textStyle.body3Bold,
                  maxLines: 2,
                ),
                AppAutoResizeText(
                  alignment: Alignment.centerLeft,
                  text: "United Kingdom United Kingdom",
                  textAlign: TextAlign.left,
                  textStyle: $styles.textStyle.body5Bold,
                  maxLines: 2,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: $styles.insets.sm,
              right: $styles.insets.sm,
            ),
            child: Container(
              height: context.heightPx * 0.15,
              decoration: BoxDecoration(
                color: $styles.colors.tertiary,
                borderRadius: BorderRadius.circular($styles.corners.xs),
              ),
              child: SvgPicture.asset(
                locationMap ?? Assets.imagesNotAvailable,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
