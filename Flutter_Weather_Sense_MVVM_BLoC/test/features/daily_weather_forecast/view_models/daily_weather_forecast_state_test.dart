import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/failures.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/view_models/daily_weather_forecast_bloc.dart';

void main() async {
  DailyWeatherForecastModel mockDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  group('Testing DailyWeatherForecastBlocState', () {
    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When the instance of its state was available, '
        'Then it should supports value equality of the state itself.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const DailyWeatherForecastState(),
        equals(const DailyWeatherForecastState()),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When the instance of its state was available, '
        'Then it should correct the value of copyWith.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const DailyWeatherForecastState().copyWith(),
        equals(const DailyWeatherForecastState()),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When the instance of its state was available, '
        'Then it should retains the old value for every parameter if null is provided.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const DailyWeatherForecastState().copyWith(
          status: null,
          dailyWeatherForecastModel: null,
          failureMessage: null,
        ),
        equals(const DailyWeatherForecastState()),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When the instance of its state was available, '
        'Then it should replaces every non-null parameter.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const DailyWeatherForecastState().copyWith(
          status: DailyWeatherForecastBlocStatus.success,
          dailyWeatherForecastModel: mockDailyWeatherForecastModel(),
          failureMessage: ServerFailure().toString(),
        ),
        equals(
          DailyWeatherForecastState(
            status: DailyWeatherForecastBlocStatus.success,
            dailyWeatherForecastModel: mockDailyWeatherForecastModel(),
            failureMessage: ServerFailure().toString(),
          ),
        ),
      );
    });
  });
}
