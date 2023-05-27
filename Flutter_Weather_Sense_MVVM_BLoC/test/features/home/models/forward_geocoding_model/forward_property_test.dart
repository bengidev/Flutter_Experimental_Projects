import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
                "wikidata": "Q14168",
                "mapbox_id": "dXJuOm1ieHBsYzpQY2hu"
            }
    ''';
  }

  ForwardProperty buildForwardPropertiesFromJson() {
    return ForwardProperty.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  ForwardProperty buildMockForwardProperties() {
    return const ForwardProperty(
      wikidata: "Q14168",
      mapboxId: "dXJuOm1ieHBsYzpQY2hu",
    );
  }

  group("Test ForwardProperty which is a part of Forward Geocoding Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid ForwardProperty object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildForwardPropertiesFromJson();

        /// ASSERT
        expect(results, isA<ForwardProperty>());
        expect(results, equals(buildMockForwardProperties()));
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the factory constructor of ForwardProperty was accessed, '
      'Then it should return a valid object of ForwardProperty subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardProperty.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(results, isA<ForwardProperty>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the toJson method from ForwardProperty object was accessed, '
      'Then it should return a valid JSON object.',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardProperty.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );
        final resultsToJson = results.toJson();

        /// ASSERT
        expect(results, isA<ForwardProperty>());
        expect(resultsToJson, isA<Map<String, dynamic>>());
      },
    );
  });
}
