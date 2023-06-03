import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/usecases/find_daily_weather_forecast_case.dart';
import 'package:mocktail/mocktail.dart';

class MockFindDailyWeatherForecastCase extends Mock
    implements FindDailyWeatherForecastCase {}

void main() async {
  late FindDailyWeatherForecastCase findDailyWeatherForecastCase;

  DailyWeatherForecastModel buildDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  double buildLatitudeCoordinate() => 52.52;

  double buildLongitudeCoordinate() => 13.419998;

  setUp(() {
    findDailyWeatherForecastCase = MockFindDailyWeatherForecastCase();
  });

  setUpAll(() {
    registerFallbackValue(
      DailyWeatherForecastParameter(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      ),
    );
  });

  group("Test find daily weather forecast's case", () {
    test(
        'Given the callable class of FindDailyWeatherForecastCase, '
        'When the DailyWeatherForecastParameter was received, '
        'Then it should return the Right of DailyWeatherForecastModel.',
        () async {
      // ARRANGE
      when(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Right(buildDailyWeatherForecastModel()),
        ),
      );

      // ACT
      final results = await findDailyWeatherForecastCase(
        DailyWeatherForecastParameter(
          latitude: buildLatitudeCoordinate(),
          longitude: buildLongitudeCoordinate(),
        ),
      );

      // ASSERT
      expect(results, isA<Right<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Right(buildDailyWeatherForecastModel())));
      verify(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      );
    });

    test(
        'Given the callable class of FindDailyWeatherForecastCase, '
        'When the DailyWeatherForecastParameter was received, '
        'Then it should return the Left of ServerFailure '
        'if the request cannot reach the server.', () async {
      // ARRANGE
      when(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Left(ServerFailure()),
        ),
      );

      // ACT
      final results = await findDailyWeatherForecastCase(
        DailyWeatherForecastParameter(
          latitude: buildLatitudeCoordinate(),
          longitude: buildLongitudeCoordinate(),
        ),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(ServerFailure())));
      verify(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      );
    });

    test(
        'Given the callable class of FindDailyWeatherForecastCase, '
        'When the DailyWeatherForecastParameter was received, '
        'Then it should return the Left of UnexpectedFailure '
        'if the provided error results was unknown.', () async {
      // ARRANGE
      when(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Left(UnexpectedFailure()),
        ),
      );

      // ACT
      final results = await findDailyWeatherForecastCase(
        DailyWeatherForecastParameter(
          latitude: buildLatitudeCoordinate(),
          longitude: buildLongitudeCoordinate(),
        ),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => findDailyWeatherForecastCase(
          any(that: isA<DailyWeatherForecastParameter>()),
        ),
      );
    });
  });
}
