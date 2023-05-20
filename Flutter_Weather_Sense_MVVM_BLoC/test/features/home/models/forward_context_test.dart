import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model/forward_context.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
                    "id": "region.181351",
                    "short_code": "ID-KB",
                    "wikidata": "Q3916",
                    "mapbox_id": "dXJuOm1ieHBsYzpBc1Ju",
                    "text": "West Kalimantan"
                }
    ''';
  }

  ForwardContext buildForwardContextFromJson() {
    return ForwardContext.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  ForwardContext buildMockForwardContext() {
    return const ForwardContext(
      id: "region.181351",
      shortCode: "ID-KB",
      wikidata: "Q3916",
      mapboxId: "dXJuOm1ieHBsYzpBc1Ju",
      text: "West Kalimantan",
    );
  }

  group("Test Forward Context which is a part of Forward Geocoding Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid ForwardContext object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildForwardContextFromJson();

        /// ASSERT
        expect(results, isA<ForwardContext>());
        expect(results, equals(buildMockForwardContext()));
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the factory constructor of ForwardContext was accessed, '
      'Then it should return a valid object of ForwardContext subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardContext.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(results, isA<ForwardContext>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the toJson method from ForwardContext object was accessed, '
      'Then it should return a valid JSON object.',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardContext.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );
        final resultsToJson = results.toJson();

        /// ASSERT
        expect(results, isA<ForwardContext>());
        expect(resultsToJson, isA<Map<String, dynamic>>());
      },
    );
  });
}
