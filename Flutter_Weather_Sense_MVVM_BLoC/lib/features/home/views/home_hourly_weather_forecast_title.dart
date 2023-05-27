import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class HomeHourlyWeatherForecastTitle extends StatelessWidget {
  const HomeHourlyWeatherForecastTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: $styles.insets.sm,
        right: $styles.insets.sm,
      ),
      child: Column(
        children: [
          AppAutoResizeText(
            width: context.widthPx,
            alignment: Alignment.centerLeft,
            text: "Hourly Forecast",
            textStyle: $styles.textStyle.h5Bold,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
