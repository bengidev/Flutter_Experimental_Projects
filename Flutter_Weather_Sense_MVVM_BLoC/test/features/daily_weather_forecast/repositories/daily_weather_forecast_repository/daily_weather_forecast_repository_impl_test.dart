import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIDailyWeatherForecastRemoteDataSource extends Mock
    implements IDailyWeatherForecastRemoteDataSource {}

void main() async {
  late IDailyWeatherForecastRemoteDataSource
      iDailyWeatherForecastRemoteDataSource;
  late DailyWeatherForecastRepositoryImpl dailyWeatherForecastRepositoryImpl;

  setUp(() {
    iDailyWeatherForecastRemoteDataSource =
        MockIDailyWeatherForecastRemoteDataSource();
    dailyWeatherForecastRepositoryImpl = DailyWeatherForecastRepositoryImpl(
      remoteDataSource: iDailyWeatherForecastRemoteDataSource,
    );
  });

  DailyWeatherForecastModel buildDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  double buildLatitudeCoordinate() => 52.52;

  double buildLongitudeCoordinate() => 13.419998;

  group('Test the implementation class DailyWeatherForecastRepositoryImpl', () {
    test(
        'Given the instance of DailyWeatherForecastRepositoryImpl, '
        'When the required instance of IDailyWeatherForecastRemoteDataSource was accessed, '
        'Then it should verify the interaction of its instance.', () async {
      // ARRANGE

      // ACT
      final results =
          await dailyWeatherForecastRepositoryImpl.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      verify(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRepositoryImpl, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of DailyWeatherForecastModel object',
        () async {
      // ARRANGE
      when(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) => Future<DailyWeatherForecastModel>.value(
          buildDailyWeatherForecastModel(),
        ),
      );

      // ACT
      final results =
          await dailyWeatherForecastRepositoryImpl.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Right<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Right(buildDailyWeatherForecastModel())));
      verify(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRepositoryImpl, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const ServerException());

      // ACT
      final results =
          await dailyWeatherForecastRepositoryImpl.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(ServerFailure())));
      verify(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRepositoryImpl, '
        'When the method of findDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const UnexpectedException());

      // ACT
      final results =
          await dailyWeatherForecastRepositoryImpl.findDailyWeatherForecast(
        latitude: buildLatitudeCoordinate(),
        longitude: buildLongitudeCoordinate(),
      );

      // ASSERT
      expect(results, isA<Left<Failure, DailyWeatherForecastModel>>());
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => iDailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });
  });
}
