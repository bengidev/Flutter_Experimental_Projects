import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {"latitude":52.52,"longitude":13.419998,"generationtime_ms":0.5249977111816406,"utc_offset_seconds":7200,"timezone":"Europe/Berlin","timezone_abbreviation":"CEST","elevation":40.0,"daily_units":{"time":"iso8601","weathercode":"wmo code","temperature_2m_max":"°C","temperature_2m_min":"°C","sunrise":"iso8601","sunset":"iso8601","precipitation_probability_max":"%","windspeed_10m_max":"km/h"},"daily":{"time":["2023-06-01","2023-06-02","2023-06-03","2023-06-04","2023-06-05","2023-06-06","2023-06-07"],"weathercode":[3,3,2,2,2,1,2],"temperature_2m_max":[22.4,19.9,20.8,23.6,24.5,25.9,27.2],"temperature_2m_min":[11.2,10.4,6.9,10.4,12.5,13.4,14.7],"sunrise":["2023-06-01T04:47","2023-06-02T04:46","2023-06-03T04:45","2023-06-04T04:44","2023-06-05T04:44","2023-06-06T04:43","2023-06-07T04:43"],"sunset":["2023-06-01T21:20","2023-06-02T21:21","2023-06-03T21:23","2023-06-04T21:24","2023-06-05T21:25","2023-06-06T21:26","2023-06-07T21:26"],"precipitation_probability_max":[0,26,0,0,0,6,6],"windspeed_10m_max":[14.8,17.6,9.2,7.3,10.8,9.3,6.7]}}
    ''';
  }

  DailyWeatherForecastModel buildDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  String buildJsonDailyWeatherForecastModel() {
    final dailyWeatherForecastModel = buildDailyWeatherForecastModel();
    final mappedDailyWeatherForecastModel = dailyWeatherForecastModel.toJson();
    return json.encode(mappedDailyWeatherForecastModel);
  }

  group("Test Daily Weather Forecast Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid DailyWeatherForecastModel object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildDailyWeatherForecastModel();

        /// ASSERT
        expect(results, isA<DailyWeatherForecastModel>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the fromJson factory constructor of DailyWeatherForecastModel was accessed, '
      'Then it should return a valid object of DailyWeatherForecastModel subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final rawJson = buildRawJsonResults();
        final results = DailyWeatherForecastModel.fromJson(
          json.decode(rawJson) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(rawJson, isA<String>());
        expect(results, isA<DailyWeatherForecastModel>());
      },
    );

    test(
      'Given the object model of DailyWeather, '
      'When the defaultValue factory method of DailyWeatherForecastModel was accessed, '
      'Then it should return a valid object of DailyWeatherForecastModel subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final results = DailyWeatherForecastModel.defaultValue();

        /// ASSERT
        expect(results, isA<DailyWeatherForecastModel>());
      },
    );

    test(
      'Given the object model of DailyWeatherForecastModel, '
      'When the toJson method of DailyWeatherForecastModel was accessed, '
      'Then it should return a valid JSON string object of DailyWeatherForecastModel.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyWeatherForecastModel();
        final results = json.encode(model.toJson());

        /// ASSERT
        expect(model, isA<DailyWeatherForecastModel>());
        expect(results, isA<String>());
        expect(results, equals(buildJsonDailyWeatherForecastModel()));
      },
    );

    test(
      'Given the object model of DailyWeatherForecastModel, '
      'When the copyWith method of DailyWeatherForecastModel was accessed, '
      'Then it should return a valid modified object of DailyWeatherForecastModel.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyWeatherForecastModel();
        final results = model.copyWith();

        /// ASSERT
        expect(model, isA<DailyWeatherForecastModel>());
        expect(results, isA<DailyWeatherForecastModel>());
      },
    );
  });
}
