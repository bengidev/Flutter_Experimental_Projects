import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIDailyWeatherForecastRepository extends Mock
    implements IDailyWeatherForecastRepository {}

void main() async {
  late IDailyWeatherForecastRepository dailyWeatherForecastRepository;

  setUp(() {
    dailyWeatherForecastRepository = MockIDailyWeatherForecastRepository();
  });

  DailyWeatherForecastModel buildDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  double buildLatitudeCoordinate() => 52.52;

  double buildLongitudeCoordinate() => 13.419998;

  group('Test the base class IDailyWeatherForecastRepository', () {
    test(
        'Given the instance of IDailyWeatherForecastRepository, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Right of DailyWeatherForecastModel.',
        () async {
      // ARRANGE
      when(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Right(buildDailyWeatherForecastModel()),
        ),
      );

      // ACT
      final results =
          await dailyWeatherForecastRepository.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Right<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Right(buildDailyWeatherForecastModel())));
      verify(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IDailyWeatherForecastRepository, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Failure of ServerFailure '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Left(ServerFailure()),
        ),
      );

      // ACT
      final results =
          await dailyWeatherForecastRepository.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(ServerFailure())));
      verify(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IDailyWeatherForecastRepository, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Failure of UnexpectedFailure '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      // ARRANGE
      when(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, DailyWeatherForecastModel>>.value(
          Left(UnexpectedFailure()),
        ),
      );

      // ACT
      final results =
          await dailyWeatherForecastRepository.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => dailyWeatherForecastRepository.findDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });
  });
}
