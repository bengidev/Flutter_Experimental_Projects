import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  late MockHttpClient httpClient;
  late DailyWeatherForecastRemoteDataSourceImpl
      dailyWeatherForecastRemoteDataSourceImpl;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    httpClient = MockHttpClient();
    dailyWeatherForecastRemoteDataSourceImpl =
        DailyWeatherForecastRemoteDataSourceImpl(httpClient: httpClient);
  });

  setUpAll(() {
    registerFallbackValue(
      DailyWeatherForecastModel.defaultValue(),
    );
  });

  String buildJsonResults() {
    const rawJsonResults = '''
    {"latitude":52.52,"longitude":13.419998,"generationtime_ms":0.5249977111816406,"utc_offset_seconds":7200,"timezone":"Europe/Berlin","timezone_abbreviation":"CEST","elevation":40.0,"daily_units":{"time":"iso8601","weathercode":"wmo code","temperature_2m_max":"°C","temperature_2m_min":"°C","sunrise":"iso8601","sunset":"iso8601","precipitation_probability_max":"%","windspeed_10m_max":"km/h"},"daily":{"time":["2023-06-01","2023-06-02","2023-06-03","2023-06-04","2023-06-05","2023-06-06","2023-06-07"],"weathercode":[3,3,2,2,2,1,2],"temperature_2m_max":[22.4,19.9,20.8,23.6,24.5,25.9,27.2],"temperature_2m_min":[11.2,10.4,6.9,10.4,12.5,13.4,14.7],"sunrise":["2023-06-01T04:47","2023-06-02T04:46","2023-06-03T04:45","2023-06-04T04:44","2023-06-05T04:44","2023-06-06T04:43","2023-06-07T04:43"],"sunset":["2023-06-01T21:20","2023-06-02T21:21","2023-06-03T21:23","2023-06-04T21:24","2023-06-05T21:25","2023-06-06T21:26","2023-06-07T21:26"],"precipitation_probability_max":[0,26,0,0,0,6,6],"windspeed_10m_max":[14.8,17.6,9.2,7.3,10.8,9.3,6.7]}}
    ''';
    return rawJsonResults;
  }

  group(
      'Test the implementation class of DailyWeatherForecastRemoteDataSourceImpl',
      () {
    test(
        'Given the instance of DailyWeatherForecastRemoteDataSourceImpl, '
        'When the required instance of HttpClient was accessed, '
        'Then it should verify the interaction of its instance.', () async {
      // ARRANGE
      when(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(buildJsonResults(), 200));

      // ACT
      final results = await dailyWeatherForecastRemoteDataSourceImpl
          .getDailyWeatherForecast(
        latitude: 52.52,
        longitude: 13.419998,
      );

      // ASSERT
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRemoteDataSourceImpl, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of DailyWeatherForecastModel.',
        () async {
      // ARRANGE
      when(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(buildJsonResults(), 200));

      // ACT
      final results = await dailyWeatherForecastRemoteDataSourceImpl
          .getDailyWeatherForecast(
        latitude: 52.52,
        longitude: 13.419998,
      );

      // ASSERT
      expect(results, isA<DailyWeatherForecastModel>());
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRemoteDataSourceImpl, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(const ServerException());

      // ACT
      final results =
          dailyWeatherForecastRemoteDataSourceImpl.getDailyWeatherForecast;

      // ASSERT
      expect(
        () => results(
          latitude: 52.52,
          longitude: 13.419998,
        ),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of DailyWeatherForecastRemoteDataSourceImpl, '
        'When the method of getDailyWeatherForecast was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(const UnexpectedException());

      // ACT
      final results =
          dailyWeatherForecastRemoteDataSourceImpl.getDailyWeatherForecast;

      // ASSERT
      expect(
        () => results(
          latitude: 52.52,
          longitude: 13.419998,
        ),
        throwsA(isA<UnexpectedException>()),
      );
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });
  });
}
