import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';

class HomeHourlyWeatherForecastCard extends StatelessWidget {
  /// Show the [HourlyWeatherForecastModel] results
  /// to describe how the latest weather forecast condition was.
  final HourlyWeatherForecastModel hourlyWeatherForecastModel;

  /// Describe the current day situation.
  final String dayDescription;

  const HomeHourlyWeatherForecastCard({
    super.key,
    required this.hourlyWeatherForecastModel,
    required this.dayDescription,
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
          boxShadow: kElevationToShadow[3],
        ),
        child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _extractWeatherForecastLength(
            hourlyWeatherForecastModel: hourlyWeatherForecastModel,
          ),
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
                            text: _extractWeatherForecastTime(
                              hourlyWeatherForecastModel:
                                  hourlyWeatherForecastModel,
                              index: index,
                            ),
                            textStyle: $styles.textStyle.body4Bold,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                          child: SvgPicture.asset(
                            _extractWeatherForecastImage(
                              dayDescription: dayDescription,
                              hourlyWeatherForecastModel:
                                  hourlyWeatherForecastModel,
                              index: index,
                            ),
                            width: context.widthPx,
                            height: context.heightPx,
                          ),
                        ),
                        SizedBox(
                          width: context.widthPx * 0.5,
                          child: AppAutoResizeText(
                            text: "${_extractWeatherForecastTemperature(
                              hourlyWeatherForecastModel:
                                  hourlyWeatherForecastModel,
                              index: index,
                            )}°",
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

  int _extractWeatherForecastLength({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
  }) {
    return hourlyWeatherForecastModel.hourlyNextWeather.weatherCode.length;
  }

  String _extractWeatherForecastTime({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
    required int index,
  }) {
    final hourlyNextWeather = hourlyWeatherForecastModel.hourlyNextWeather;
    final forecastTimes = hourlyNextWeather.time;
    final singleForecastTime = forecastTimes.elementAt(index);
    final formattedSingleForecastTime = singleForecastTime.split("T");
    return formattedSingleForecastTime.last;
  }

  String _extractWeatherForecastImage({
    required String dayDescription,
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
    required int index,
  }) {
    final hourlyNextWeather = hourlyWeatherForecastModel.hourlyNextWeather;
    final forecastWeatherCodes = hourlyNextWeather.weatherCode;
    final forecastWeatherTimes = hourlyNextWeather.time;
    final singleWeatherCode = forecastWeatherCodes.elementAt(index);
    final singleWeatherTime = forecastWeatherTimes.elementAt(index);
    final generatedWeatherImage = WeatherForecastHelper.generateWeatherImage(
      weatherCode: singleWeatherCode,
      dayDescription: GreetingOfDay.getFromTime(
        time: DateTime.parse(singleWeatherTime),
      ),
    );
    return generatedWeatherImage;
  }

  String _extractWeatherForecastTemperature({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
    required int index,
  }) {
    final hourlyNextWeather = hourlyWeatherForecastModel.hourlyNextWeather;
    final forecastTemperatures = hourlyNextWeather.temperature2M;
    return forecastTemperatures.elementAt(index).toString();
  }
}
