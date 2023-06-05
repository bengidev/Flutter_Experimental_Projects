import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class DailyWeatherCard extends StatelessWidget {
  /// Show the weather image from inside assets folder.
  final String weatherImage;

  /// Describe the current weather situation.
  final String weatherDescription;

  /// Show the maximal temperature of the current weather.
  final double temperatureMax;

  /// Show the minimal temperature of the current weather.
  final double temperatureMin;

  /// Show the wind speed at 10 meters above ground
  /// of the current weather.
  final double windSpeed;

  /// Show the percentage precipitation probability
  /// of the current weather.
  final int precipitationProbability;

  const DailyWeatherCard({
    super.key,
    required this.weatherImage,
    required this.weatherDescription,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.windSpeed,
    required this.precipitationProbability,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all($styles.insets.sm),
      child: Container(
        width: context.widthPx,
        height: context.heightPct(0.55),
        decoration: BoxDecoration(
          color: $styles.colors.tertiary,
          borderRadius: BorderRadius.circular($styles.corners.sm),
          boxShadow: kElevationToShadow[3],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                $styles.insets.xs,
                $styles.insets.lg,
                $styles.insets.xs,
                $styles.insets.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/rainbow.svg',
                        width: context.widthPct(0.03),
                        height: context.heightPct(0.03),
                      ),
                      Gap($styles.insets.xxs),
                      AppAutoResizeText(
                        width: context.widthPct(0.3),
                        alignment: Alignment.center,
                        text: "Current Weather",
                        textStyle: $styles.textStyle.body5Bold,
                        textAlign: TextAlign.center,
                      ),
                      Gap($styles.insets.lg),
                      Column(
                        children: [
                          SvgPicture.asset(
                            weatherImage,
                            width: context.widthPct(0.05),
                            height: context.heightPct(0.05),
                          ),
                          AppAutoResizeText(
                            width: context.widthPct(0.4),
                            alignment: Alignment.center,
                            text: weatherDescription,
                            textStyle: $styles.textStyle.body5,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: $styles.insets.sm,
              thickness: 2,
              color: $styles.colors.primary,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                $styles.insets.lg,
                $styles.insets.xs,
                $styles.insets.xs,
                $styles.insets.xs,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/mild.svg',
                    width: context.widthPct(0.03),
                    height: context.heightPct(0.03),
                  ),
                  Gap($styles.insets.xxs),
                  AppAutoResizeText(
                    alignment: Alignment.center,
                    text: "Temperature",
                    textStyle: $styles.textStyle.body5Bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    AppAutoResizeText(
                      width: context.widthPct(0.3),
                      alignment: Alignment.center,
                      text: "Maximum",
                      textStyle: $styles.textStyle.body5,
                      textAlign: TextAlign.center,
                    ),
                    AppAutoResizeText(
                      width: context.widthPct(0.3),
                      alignment: Alignment.center,
                      text: "$temperatureMax °C",
                      textStyle: $styles.textStyle.body5Bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    AppAutoResizeText(
                      width: context.widthPct(0.3),
                      alignment: Alignment.center,
                      text: "Minimum",
                      textStyle: $styles.textStyle.body5,
                      textAlign: TextAlign.center,
                    ),
                    AppAutoResizeText(
                      width: context.widthPct(0.3),
                      alignment: Alignment.center,
                      text: "$temperatureMin °C",
                      textStyle: $styles.textStyle.body5Bold,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              height: $styles.insets.lg,
              thickness: 2,
              color: $styles.colors.primary,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.all($styles.insets.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/blizzard.svg',
                        width: context.widthPct(0.03),
                        height: context.heightPct(0.03),
                      ),
                      Gap($styles.insets.xxs),
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: "Wind Speed",
                        textStyle: $styles.textStyle.body5Bold,
                        textAlign: TextAlign.center,
                      ),
                      Gap($styles.insets.xl),
                      Column(
                        children: [
                          AppAutoResizeText(
                            width: context.widthPct(0.3),
                            alignment: Alignment.center,
                            text: windSpeed.toString(),
                            textStyle: $styles.textStyle.body5Bold,
                            textAlign: TextAlign.center,
                            minFontSize: 24,
                          ),
                          AppAutoResizeText(
                            alignment: Alignment.center,
                            text: "km/H",
                            textStyle: $styles.textStyle.body5,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: $styles.insets.xs,
              thickness: 2,
              color: $styles.colors.primary,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.all($styles.insets.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/hazzy.svg',
                        width: context.widthPct(0.03),
                        height: context.heightPct(0.03),
                      ),
                      Gap($styles.insets.xxs),
                      AppAutoResizeText(
                        alignment: Alignment.center,
                        text: "Precipitation",
                        textStyle: $styles.textStyle.body5Bold,
                        textAlign: TextAlign.center,
                      ),
                      Gap($styles.insets.xl),
                      Column(
                        children: [
                          AppAutoResizeText(
                            width: context.widthPct(0.3),
                            alignment: Alignment.center,
                            text: precipitationProbability.toString(),
                            textStyle: $styles.textStyle.body5Bold,
                            textAlign: TextAlign.center,
                            minFontSize: 24,
                          ),
                          AppAutoResizeText(
                            alignment: Alignment.center,
                            text: "(%) percentage",
                            textStyle: $styles.textStyle.body5,
                            textAlign: TextAlign.center,
                          ),
                        ],
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
