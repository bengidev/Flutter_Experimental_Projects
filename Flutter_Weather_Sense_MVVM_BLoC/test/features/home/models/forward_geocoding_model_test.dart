import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

void main() async {
  String buildRawJsonResults() {
    return '''
    {
    "type": "FeatureCollection",
    "query": [
        "pontianak"
    ],
    "features": [
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
        ],
    "attribution": "NOTICE: © 2023 Mapbox and its suppliers. All rights reserved. Use of this data is subject to the Mapbox Terms of Service (https://www.mapbox.com/about/maps/). This response and the information it contains may not be retained. POI(s) provided by Foursquare."
}
    ''';
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

  ForwardGeocodingModel buildForwardGeocodingModelFromJson() {
    return ForwardGeocodingModel.fromJson(
      json.decode(buildRawJsonResults()) as Map<String, dynamic>,
    );
  }

  ForwardGeocodingModel buildMockForwardGeocodingModel() {
    return ForwardGeocodingModel(
      type: "FeatureCollection",
      queries: const <String>["pontianak"],
      features: <ForwardFeature>[buildMockForwardFeature()],
      attribution:
          "NOTICE: © 2023 Mapbox and its suppliers. All rights reserved. Use of this data is subject to the Mapbox Terms of Service (https://www.mapbox.com/about/maps/). This response and the information it contains may not be retained. POI(s) provided by Foursquare.",
    );
  }

  group("Test Forward Geocoding Model.", () {
    test(
      'Given the raw data of JSON results from API, '
      'When the raw data was converted into JSON object, '
      'Then it should return a valid ForwardGeocodingModel object .',
      () async {
        /// ARRANGE
        /// ACT
        final results = buildForwardGeocodingModelFromJson();

        /// ASSERT
        expect(results, isA<ForwardGeocodingModel>());
        expect(results, equals(buildMockForwardGeocodingModel()));
      },
    );
    //
    test(
      'Given the raw data of JSON results from API, '
      'When the factory constructor of ForwardGeocodingModel was accessed, '
      'Then it should return a valid object of ForwardGeocodingModel subtype .',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardGeocodingModel.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );

        /// ASSERT
        expect(results, isA<ForwardGeocodingModel>());
      },
    );

    test(
      'Given the raw data of JSON results from API, '
      'When the toJson method from ForwardGeocodingModel object was accessed, '
      'Then it should return a valid JSON object.',
      () async {
        /// ARRANGE
        /// ACT
        final results = ForwardGeocodingModel.fromJson(
          json.decode(buildRawJsonResults()) as Map<String, dynamic>,
        );
        final resultsToJson = results.toJson();

        /// ASSERT
        expect(results, isA<ForwardGeocodingModel>());
        expect(resultsToJson, isA<Map<String, dynamic>>());
      },
    );
  });
}
