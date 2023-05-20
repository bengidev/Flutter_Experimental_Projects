import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class HomeHourlyForecastCard extends StatelessWidget {
  /// Function will triggered when one of the
  /// [HomeHourlyForecastCard] was pressed.
  final void Function()? onTap;

  /// Show the early warning icon to describe
  /// how the current warning looks like.
  final String? warningIcon;

  /// Describe the early warning information
  /// based from the current area.
  final String? warningDescription;

  /// Describe the location of impacted
  /// early warning.
  final String? locationText;

  /// Describe the warning information of
  /// its location.
  final String? warningInformation;

  const HomeHourlyForecastCard({
    super.key,
    this.onTap,
    this.warningIcon,
    this.warningDescription,
    this.locationText,
    this.warningInformation,
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
        height: context.heightPx * 0.2,
        padding: EdgeInsets.all($styles.insets.xxs),
        decoration: BoxDecoration(
          color: $styles.colors.tertiary,
          borderRadius: BorderRadius.circular($styles.corners.xs),
          boxShadow: kElevationToShadow[6],
        ),
        child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: context.widthPx * 0.2,
              height: context.heightPx,
              padding: EdgeInsets.all($styles.insets.xs),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Gap($styles.insets.xs),
                        SizedBox(
                          width: context.widthPx * 0.5,
                          child: AppAutoResizeText(
                            text: warningInformation ?? "Now",
                            textStyle: $styles.textStyle.body4Bold,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                            warningIcon ?? 'assets/images/thunder_snow.svg',
                            width: context.widthPx,
                            height: context.heightPx,
                          ),
                        ),
                        SizedBox(
                          width: context.widthPx * 0.5,
                          child: AppAutoResizeText(
                            text: warningInformation ?? "31°",
                            textStyle: $styles.textStyle.body4,
                            maxLines: 2,
                          ),
                        ),
                        Gap($styles.insets.xs),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
