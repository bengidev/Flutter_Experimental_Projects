import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/view_models/daily_weather_forecast_bloc.dart';

void main() async {
  double buildLatitudeCoordinate() => 52.52;

  double buildLongitudeCoordinate() => 13.419998;

  group('Testing FindDailyWeatherForecastEvent', () {
    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When FindDailyWeatherForecastEvent was added, '
        'Then it should supports value equality from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        FindDailyWeatherForecastEvent(
          latitude: buildLatitudeCoordinate(),
          longitude: buildLongitudeCoordinate(),
        ),
        equals(
          FindDailyWeatherForecastEvent(
            latitude: buildLatitudeCoordinate(),
            longitude: buildLongitudeCoordinate(),
          ),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When FindDailyWeatherForecastEvent was added, '
        'Then it should correct the props from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        FindDailyWeatherForecastEvent(
          latitude: buildLatitudeCoordinate(),
          longitude: buildLongitudeCoordinate(),
        ).props,
        equals(<Object?>[
          buildLatitudeCoordinate(),
          buildLongitudeCoordinate(),
        ]),
      );
    });
  });
}
