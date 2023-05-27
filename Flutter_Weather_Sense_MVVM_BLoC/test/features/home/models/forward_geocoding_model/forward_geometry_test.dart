import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
                "type": "Point",
                "coordinates": [
                    109.344749,
                    -0.02269
                ]
            }
    ''';
  }

  ForwardGeometry buildForwardGeometryFromJson() {
    return ForwardGeometry.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  ForwardGeometry buildMockForwardGeometry() {
    return const ForwardGeometry(
      type: "Point",
      coordinates: <double>[
        109.344749,
        -0.02269,
      ],
    );
  }

  group("Test ForwardGeometry which is a part of Forward Geocoding Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid ForwardGeometry object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildForwardGeometryFromJson();

        /// ASSERT
        expect(results, isA<ForwardGeometry>());
        expect(results, equals(buildMockForwardGeometry()));
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the factory constructor of ForwardGeometry was accessed, '
      'Then it should return a valid object of ForwardGeometry subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardGeometry.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(results, isA<ForwardGeometry>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the toJson method from ForwardGeometry object was accessed, '
      'Then it should return a valid JSON object.',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardGeometry.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );
        final resultsToJson = results.toJson();

        /// ASSERT
        expect(results, isA<ForwardGeometry>());
        expect(resultsToJson, isA<Map<String, dynamic>>());
      },
    );
  });
}
