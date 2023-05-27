import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_current_weather.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {"temperature":12.0,"windspeed":15.0,"winddirection":294.0,"weathercode":3,"is_day":0,"time":"2023-05-23T23:00"}
    ''';
  }

  HourlyCurrentWeather buildHourlyCurrentWeather() {
    return HourlyCurrentWeather.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  String buildJsonHourlyCurrentWeather() {
    final hourlyCurrentWeather = buildHourlyCurrentWeather();
    final mappedHourlyCurrentWeather = hourlyCurrentWeather.toJson();
    return json.encode(mappedHourlyCurrentWeather);
  }

  group("Test Hourly Current Weather.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid HourlyCurrentWeather object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildHourlyCurrentWeather();

        /// ASSERT
        expect(results, isA<HourlyCurrentWeather>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the fromJson factory constructor of HourlyCurrentWeather was accessed, '
      'Then it should return a valid object of HourlyCurrentWeather subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final rawJson = buildRawJsonResults();
        final results = HourlyCurrentWeather.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(rawJson, isA<String>());
        expect(results, isA<HourlyCurrentWeather>());
      },
    );

    test(
      'Given the object model of HourlyCurrentWeather, '
      'When the defaultValue factory method of HourlyCurrentWeather was accessed, '
      'Then it should return a valid object of HourlyCurrentWeather subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final results = HourlyCurrentWeather.defaultValue();

        /// ASSERT
        expect(results, isA<HourlyCurrentWeather>());
      },
    );

    test(
      'Given the object model of HourlyCurrentWeather, '
      'When the toJson method of HourlyCurrentWeather was accessed, '
      'Then it should return a valid JSON string object of HourlyCurrentWeather.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildHourlyCurrentWeather();
        final results = json.encode(model.toJson());

        /// ASSERT
        expect(model, isA<HourlyCurrentWeather>());
        expect(results, isA<String>());
        expect(results, equals(buildJsonHourlyCurrentWeather()));
      },
    );

    test(
      'Given the object model of HourlyCurrentWeather, '
      'When the copyWith method of HourlyCurrentWeather was accessed, '
      'Then it should return a valid modified object of HourlyCurrentWeather.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildHourlyCurrentWeather();
        final results = model.copyWith();

        /// ASSERT
        expect(model, isA<HourlyCurrentWeather>());
        expect(results, isA<HourlyCurrentWeather>());
      },
    );
  });
}
