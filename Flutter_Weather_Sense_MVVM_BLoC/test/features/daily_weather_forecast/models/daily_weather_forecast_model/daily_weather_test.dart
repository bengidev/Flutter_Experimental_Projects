import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {"time":["2023-06-01","2023-06-02","2023-06-03","2023-06-04","2023-06-05","2023-06-06","2023-06-07"],"weathercode":[3,3,2,2,2,1,2],"temperature_2m_max":[22.4,19.9,20.8,23.6,24.5,25.9,27.2],"temperature_2m_min":[11.2,10.4,6.9,10.4,12.5,13.4,14.7],"sunrise":["2023-06-01T04:47","2023-06-02T04:46","2023-06-03T04:45","2023-06-04T04:44","2023-06-05T04:44","2023-06-06T04:43","2023-06-07T04:43"],"sunset":["2023-06-01T21:20","2023-06-02T21:21","2023-06-03T21:23","2023-06-04T21:24","2023-06-05T21:25","2023-06-06T21:26","2023-06-07T21:26"],"precipitation_probability_max":[0,26,0,0,0,6,6],"windspeed_10m_max":[14.8,17.6,9.2,7.3,10.8,9.3,6.7]}
    ''';
  }

  DailyWeather buildDailyWeather() {
    return DailyWeather.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  String buildJsonDailyWeather() {
    final dailyWeather = buildDailyWeather();
    final mappedDailyWeather = dailyWeather.toJson();
    return json.encode(mappedDailyWeather);
  }

  group("Test Daily Weather.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid DailyWeather object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildDailyWeather();

        /// ASSERT
        expect(results, isA<DailyWeather>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the fromJson factory constructor of DailyWeather was accessed, '
      'Then it should return a valid object of DailyWeather subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final rawJson = buildRawJsonResults();
        final results = DailyWeather.fromJson(
          json.decode(rawJson) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(rawJson, isA<String>());
        expect(results, isA<DailyWeather>());
      },
    );

    test(
      'Given the object model of DailyWeather, '
      'When the defaultValue factory method of DailyWeather was accessed, '
      'Then it should return a valid object of DailyWeather subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final results = DailyWeather.defaultValue();

        /// ASSERT
        expect(results, isA<DailyWeather>());
      },
    );

    test(
      'Given the object model of DailyWeather, '
      'When the toJson method of DailyWeather was accessed, '
      'Then it should return a valid JSON string object of DailyWeather.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyWeather();
        final results = json.encode(model.toJson());

        /// ASSERT
        expect(model, isA<DailyWeather>());
        expect(results, isA<String>());
        expect(results, equals(buildJsonDailyWeather()));
      },
    );

    test(
      'Given the object model of DailyWeather, '
      'When the copyWith method of DailyWeather was accessed, '
      'Then it should return a valid modified object of DailyWeather.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyWeather();
        final results = model.copyWith();

        /// ASSERT
        expect(model, isA<DailyWeather>());
        expect(results, isA<DailyWeather>());
      },
    );
  });
}
