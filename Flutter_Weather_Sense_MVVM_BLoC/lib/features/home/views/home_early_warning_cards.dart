import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/generated/assets.dart';

class HomeEarlyWarningCards extends HookWidget {
  /// Function will triggered when one of the
  /// [HomeEarlyWarningCards] was pressed.
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

  const HomeEarlyWarningCards({
    super.key,
    this.onTap,
    this.warningIcon,
    this.warningDescription,
    this.locationText,
    this.warningInformation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: $styles.insets.xs,
        right: $styles.insets.xs,
      ),
      width: context.widthPx,
      height: context.heightPx * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Gap($styles.insets.sm),
          Container(
            padding: EdgeInsets.all($styles.insets.xs),
            width: context.widthPx * 0.5,
            height: context.heightPx * 0.2,
            decoration: BoxDecoration(
              color: $styles.colors.tertiary,
              borderRadius: BorderRadius.circular($styles.corners.xs),
              boxShadow: kElevationToShadow[6],
            ),
            child: Material(
              color: $styles.colors.tertiary,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular($styles.corners.xs),
              type: MaterialType.card,
              child: InkWell(
                onTap: onTap ?? () {},
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          warningIcon ?? Assets.imagesNotAvailable,
                          width: context.widthPx * 0.05,
                          height: context.heightPx * 0.05,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: AppAutoResizeText(
                              alignment: Alignment.centerLeft,
                              text: warningDescription ?? "Empty",
                              textStyle: $styles.textStyle.body5,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: context.widthPx * 0.5,
                      height: context.heightPx * 0.125,
                      decoration: BoxDecoration(
                        color: $styles.colors.offWhite,
                        borderRadius: BorderRadius.circular(
                          $styles.corners.xs,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all($styles.insets.xxs),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),
                                Gap($styles.insets.xs),
                                Expanded(
                                  child: AppAutoResizeText(
                                    text: locationText ?? "Empty",
                                    textAlign: TextAlign.left,
                                    textStyle: $styles.textStyle.body5Bold,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: context.widthPx * 0.5,
                                child: AppAutoResizeText(
                                  text: warningInformation ?? "Empty",
                                  textStyle: $styles.textStyle.body5,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap($styles.insets.sm),
        ],
      ),
    );
  }
}
