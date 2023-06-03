import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIDailyWeatherForecastRemoteDataSource extends Mock
    implements IDailyWeatherForecastRemoteDataSource {}

void main() async {
  late IDailyWeatherForecastRemoteDataSource
      dailyWeatherForecastRemoteDataSource;
  setUp(() {
    dailyWeatherForecastRemoteDataSource =
        MockIDailyWeatherForecastRemoteDataSource();
  });

  setUpAll(() {
    registerFallbackValue(
      DailyWeatherForecastModel.defaultValue(),
    );
  });

  DailyWeatherForecastModel buildMockDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  group('Test the base class of IDailyWeatherForecastRemoteDataSource', () {
    test(
        'Given the instance of IDailyWeatherForecastRemoteDataSource, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of DailyWeatherForecastModel.',
        () async {
      // ARRANGE
      when(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) async => buildMockDailyWeatherForecastModel(),
      );

      // ACT
      final results =
          await dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
        latitude: 0.0,
        longitude: 0.0,
      );

      // ASSERT
      expect(results, isA<DailyWeatherForecastModel>());
      verify(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IDailyWeatherForecastRemoteDataSource, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const ServerException());

      // ACT
      final results =
          dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast;

      // ASSERT
      expect(
        () => results(latitude: 0.0, longitude: 0.0),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IDailyWeatherForecastRemoteDataSource, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const UnexpectedException());

      // ACT
      final results =
          dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast;

      // ASSERT
      expect(
        () => results(latitude: 0.0, longitude: 0.0),
        throwsA(isA<UnexpectedException>()),
      );
      verify(
        () => dailyWeatherForecastRemoteDataSource.getDailyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });
  });
}
