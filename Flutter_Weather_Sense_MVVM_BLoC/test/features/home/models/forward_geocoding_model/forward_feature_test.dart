import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
            "id": "place.4048999",
            "type": "Feature",
            "place_type": [
                "place"
            ],
            "relevance": 1,
            "properties": {
                "wikidata": "Q14168",
                "mapbox_id": "dXJuOm1ieHBsYzpQY2hu"
            },
            "text": "Pontianak",
            "place_name": "Pontianak, West Kalimantan, Indonesia",
            "bbox": [
                109.272099,
                -0.097407,
                109.384123,
                0.038096
            ],
            "center": [
                109.344749,
                -0.02269
            ],
            "geometry": {
                "type": "Point",
                "coordinates": [
                    109.344749,
                    -0.02269
                ]
            },
            "context": [
                {
                    "id": "region.181351",
                    "short_code": "ID-KB",
                    "wikidata": "Q3916",
                    "mapbox_id": "dXJuOm1ieHBsYzpBc1Ju",
                    "text": "West Kalimantan"
                },
                {
                    "id": "country.8807",
                    "short_code": "id",
                    "wikidata": "Q252",
                    "mapbox_id": "dXJuOm1ieHBsYzpJbWM",
                    "text": "Indonesia"
                }
            ]
        }
    ''';
  }

  ForwardFeature buildForwardFeatureFromJson() {
    return ForwardFeature.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  ForwardFeature buildMockForwardFeature() {
    return const ForwardFeature(
      id: "place.4048999",
      type: "Feature",
      placeType: <String>["place"],
      relevance: 1,
      properties: ForwardProperty(
        wikidata: "Q14168",
        mapboxId: "dXJuOm1ieHBsYzpQY2hu",
      ),
      text: "Pontianak",
      placeName: "Pontianak, West Kalimantan, Indonesia",
      bbox: <double>[
        109.272099,
        -0.097407,
        109.384123,
        0.038096,
      ],
      center: <double>[
        109.344749,
        -0.02269,
      ],
      geometry: ForwardGeometry(
        type: "Point",
        coordinates: <double>[
          109.344749,
          -0.02269,
        ],
      ),
      context: <ForwardContext>[
        ForwardContext(
          id: "region.181351",
          shortCode: "ID-KB",
          wikidata: "Q3916",
          mapboxId: "dXJuOm1ieHBsYzpBc1Ju",
          text: "West Kalimantan",
        ),
        ForwardContext(
          id: "country.8807",
          shortCode: "id",
          wikidata: "Q252",
          mapboxId: "dXJuOm1ieHBsYzpJbWM",
          text: "Indonesia",
        ),
      ],
    );
  }

  group("Test Forward Feature which is a part of Forward Geocoding Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid ForwardFeature object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildForwardFeatureFromJson();

        /// ASSERT
        expect(results, isA<ForwardFeature>());
        expect(results, equals(buildMockForwardFeature()));
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the factory constructor of ForwardFeature was accessed, '
      'Then it should return a valid object of ForwardFeature subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardFeature.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(results, isA<ForwardFeature>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the toJson method from ForwardFeature object was accessed, '
      'Then it should return a valid JSON object.',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardFeature.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );
        final resultsToJson = results.toJson();

        /// ASSERT
        expect(results, isA<ForwardFeature>());
        expect(resultsToJson, isA<Map<String, dynamic>>());
      },
    );
  });
}
