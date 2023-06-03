import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class DailySunCard extends StatelessWidget {
  /// Show the forecast time of sunrise.
  final String sunriseTime;

  /// Show the forecast time of sunset.
  final String sunsetTime;

  const DailySunCard({
    super.key,
    required this.sunriseTime,
    required this.sunsetTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: $styles.insets.sm,
        right: $styles.insets.sm,
      ),
      child: Container(
        width: context.widthPx,
        height: context.heightPct(0.12),
        decoration: BoxDecoration(
          color: $styles.colors.tertiary,
          borderRadius: BorderRadius.circular($styles.corners.sm),
          boxShadow: kElevationToShadow[3],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: context.widthPct(0.4),
              height: context.heightPct(0.1),
              padding: EdgeInsets.all($styles.insets.xxs),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/sunrise.svg',
                    width: context.widthPct(0.08),
                    height: context.heightPct(0.08),
                  ),
                  Gap($styles.insets.xs),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: "Sunrise",
                        textStyle: $styles.textStyle.title1Bold,
                        minFontSize: 16,
                      ),
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: sunriseTime,
                        textStyle: $styles.textStyle.body5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: context.widthPct(0.4),
              height: context.heightPct(0.1),
              padding: EdgeInsets.all($styles.insets.xxs),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/sunset.svg',
                    width: context.widthPct(0.08),
                    height: context.heightPct(0.08),
                  ),
                  Gap($styles.insets.xs),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: "Sunset",
                        textStyle: $styles.textStyle.title1Bold,
                        minFontSize: 16,
                      ),
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: sunsetTime,
                        textStyle: $styles.textStyle.body5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
