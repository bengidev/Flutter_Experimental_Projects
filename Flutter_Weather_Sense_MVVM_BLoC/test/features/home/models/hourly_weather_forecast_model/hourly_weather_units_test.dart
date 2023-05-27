import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
        "time": "iso8601",
        "temperature_2m": "°C",
        "relativehumidity_2m": "%",
        "dewpoint_2m": "°C",
        "apparent_temperature": "°C",
        "precipitation_probability": "%",
        "weathercode": "wmo code",
        "surface_pressure": "hPa",
        "visibility": "m",
        "windspeed_10m": "km/h"
        }
    ''';
  }

  HourlyWeatherUnits buildHourlyWeatherUnits() {
    return HourlyWeatherUnits.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  String buildJsonHourlyWeatherUnits() {
    final hourlyWeatherUnits = buildHourlyWeatherUnits();
    final mappedHourlyWeatherUnits = hourlyWeatherUnits.toJson();
    return json.encode(mappedHourlyWeatherUnits);
  }

  group("Test Hourly Weather Units.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid HourlyWeatherUnits object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildHourlyWeatherUnits();

        /// ASSERT
        expect(results, isA<HourlyWeatherUnits>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the fromJson factory constructor of HourlyWeatherUnits was accessed, '
      'Then it should return a valid object of HourlyWeatherUnits subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final rawJson = buildRawJsonResults();
        final results = HourlyWeatherUnits.fromJson(
          json.decode(rawJson) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(rawJson, isA<String>());
        expect(results, isA<HourlyWeatherUnits>());
      },
    );

    test(
      'Given the object model of HourlyWeatherUnits, '
      'When the defaultValue factory method of HourlyWeatherUnits was accessed, '
      'Then it should return a valid object of HourlyWeatherUnits subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final results = HourlyWeatherUnits.defaultValue();

        /// ASSERT
        expect(results, isA<HourlyWeatherUnits>());
      },
    );

    test(
      'Given the object model of HourlyWeatherUnits, '
      'When the toJson method of HourlyWeatherUnits was accessed, '
      'Then it should return a valid JSON string object of HourlyWeatherUnits.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildHourlyWeatherUnits();
        final results = json.encode(model.toJson());

        /// ASSERT
        expect(model, isA<HourlyWeatherUnits>());
        expect(results, isA<String>());
        expect(results, equals(buildJsonHourlyWeatherUnits()));
      },
    );

    test(
      'Given the object model of HourlyWeatherUnits, '
      'When the copyWith method of HourlyWeatherUnits was accessed, '
      'Then it should return a valid modified object of HourlyWeatherUnits.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildHourlyWeatherUnits();
        final results = model.copyWith();

        /// ASSERT
        expect(model, isA<HourlyWeatherUnits>());
        expect(results, isA<HourlyWeatherUnits>());
      },
    );
  });
}
