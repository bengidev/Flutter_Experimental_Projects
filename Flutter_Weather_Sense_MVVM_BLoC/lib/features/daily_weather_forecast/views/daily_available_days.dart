import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/dependency_injections/dependency_injection.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/widgets/app_auto_resize_text.dart';
import 'package:sized_context/sized_context.dart';

class DailyAvailableDays extends StatelessWidget {
  /// Show the available days to request the weather forecast.
  final List<String> availableDays;

  /// Track selected index value from list.
  final int selectedDayIndex;

  /// Trigger this function when
  /// one of available days was selected.
  final Future<void> Function(int index) onDayPressed;

  const DailyAvailableDays({
    super.key,
    required this.availableDays,
    required this.selectedDayIndex,
    required this.onDayPressed,
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
        height: context.heightPct(0.07),
        padding: EdgeInsets.all($styles.insets.xs),
        decoration: BoxDecoration(
          color: $styles.colors.tertiary,
          borderRadius: BorderRadius.circular($styles.corners.sm),
          boxShadow: kElevationToShadow[3],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: availableDays.length,
          itemBuilder: (context, index) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(
                  left: $styles.insets.xxs,
                  right: $styles.insets.xxs,
                ),
                child: selectedDayIndex == index
                    ? ElevatedButton(
                        key: ValueKey(availableDays.elementAt(index)),
                        onPressed: () => onDayPressed(index),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular($styles.corners.sm),
                          ),
                          backgroundColor: $styles.colors.primary,
                        ),
                        child: AppAutoResizeText(
                          key: ValueKey(availableDays.elementAt(index)),
                          text: availableDays.elementAt(index),
                          textStyle: $styles.textStyle.body5Bold,
                        ),
                      )
                    : ElevatedButton(
                        key: ValueKey(availableDays.elementAt(index) * 2),
                        onPressed: () => onDayPressed(index),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular($styles.corners.sm),
                          ),
                          backgroundColor: $styles.colors.greyMedium,
                        ),
                        child: AppAutoResizeText(
                          key: ValueKey(availableDays.elementAt(index) * 2),
                          text: availableDays.elementAt(index),
                          textStyle: $styles.textStyle.body5Bold,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
