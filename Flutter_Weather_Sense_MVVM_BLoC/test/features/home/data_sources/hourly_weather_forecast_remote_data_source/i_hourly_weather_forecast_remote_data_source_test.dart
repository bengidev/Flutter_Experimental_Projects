import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/exceptions.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/hourly_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIHourlyWeatherForecastRemoteDataSource extends Mock
    implements IHourlyWeatherForecastRemoteDataSource {}

void main() async {
  late IHourlyWeatherForecastRemoteDataSource
      iHourlyWeatherForecastRemoteDataSource;
  setUp(() {
    iHourlyWeatherForecastRemoteDataSource =
        MockIHourlyWeatherForecastRemoteDataSource();
  });

  setUpAll(() {
    registerFallbackValue(
      HourlyWeatherForecastModel.defaultValue(),
    );
  });

  HourlyWeatherForecastModel buildMockHourlyWeatherForecastModel() {
    return HourlyWeatherForecastModel.defaultValue();
  }

  group('Test the base class of IHourlyWeatherForecastRemoteDataSource', () {
    test(
        'Given the instance of IHourlyWeatherForecastRemoteDataSource, '
        'When the method of getHourlyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of HourlyWeatherForecastModel.',
        () async {
      // ARRANGE
      when(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenAnswer(
        (_) async => buildMockHourlyWeatherForecastModel(),
      );

      // ACT
      final results = await iHourlyWeatherForecastRemoteDataSource
          .getHourlyWeatherForecast(latitude: 0.0, longitude: 0.0);

      // ASSERT
      expect(results, isA<HourlyWeatherForecastModel>());
      verify(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IHourlyWeatherForecastRemoteDataSource, '
        'When the method of getHourlyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const ServerException());

      // ACT
      final results =
          iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast;

      // ASSERT
      expect(
        () => results(latitude: 0.0, longitude: 0.0),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });

    test(
        'Given the instance of IHourlyWeatherForecastRemoteDataSource, '
        'When the method of getHourlyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      ).thenThrow(const UnexpectedException());

      // ACT
      final results =
          iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast;

      // ASSERT
      expect(
        () => results(latitude: 0.0, longitude: 0.0),
        throwsA(isA<UnexpectedException>()),
      );
      verify(
        () => iHourlyWeatherForecastRemoteDataSource.getHourlyWeatherForecast(
          latitude: any(named: 'latitude', that: isA<double>()),
          longitude: any(named: 'longitude', that: isA<double>()),
        ),
      );
    });
  });
}
