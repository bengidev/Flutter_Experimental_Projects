import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {"time":"iso8601","weathercode":"wmo code","temperature_2m_max":"°C","temperature_2m_min":"°C","sunrise":"iso8601","sunset":"iso8601","precipitation_probability_max":"%","windspeed_10m_max":"km/h"}
    ''';
  }

  DailyUnits buildDailyUnits() {
    return DailyUnits.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  String buildJsonDailyUnits() {
    final dailyUnits = buildDailyUnits();
    final mappedDailyUnits = dailyUnits.toJson();
    return json.encode(mappedDailyUnits);
  }

  group("Test Daily Units.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid DailyUnits object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildDailyUnits();

        /// ASSERT
        expect(results, isA<DailyUnits>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the fromJson factory constructor of DailyUnits was accessed, '
      'Then it should return a valid object of DailyUnits subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final rawJson = buildRawJsonResults();
        final results = DailyUnits.fromJson(
          json.decode(rawJson) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(rawJson, isA<String>());
        expect(results, isA<DailyUnits>());
      },
    );

    test(
      'Given the object model of DailyUnits, '
      'When the defaultValue factory method of DailyUnits was accessed, '
      'Then it should return a valid object of DailyUnits subtype.',
      () async {
        /// ARRANGE
        /// ACT
        final results = DailyUnits.defaultValue();

        /// ASSERT
        expect(results, isA<DailyUnits>());
      },
    );

    test(
      'Given the object model of DailyUnits, '
      'When the toJson method of DailyUnits was accessed, '
      'Then it should return a valid JSON string object of DailyUnits.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyUnits();
        final results = json.encode(model.toJson());

        /// ASSERT
        expect(model, isA<DailyUnits>());
        expect(results, isA<String>());
        expect(results, equals(buildJsonDailyUnits()));
      },
    );

    test(
      'Given the object model of DailyUnits, '
      'When the copyWith method of DailyUnits was accessed, '
      'Then it should return a valid modified object of DailyUnits.',
      () async {
        /// ARRANGE
        /// ACT
        final model = buildDailyUnits();
        final results = model.copyWith();

        /// ASSERT
        expect(model, isA<DailyUnits>());
        expect(results, isA<DailyUnits>());
      },
    );
  });
}
