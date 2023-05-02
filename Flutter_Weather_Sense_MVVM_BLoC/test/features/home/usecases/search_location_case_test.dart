import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_input_parameter.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchLocationCase extends Mock implements SearchLocationCase {}

void main() {
  late MockSearchLocationCase searchLocationCase;

  setUp(() {
    searchLocationCase = MockSearchLocationCase();
  });

  setUpAll(() {
    registerFallbackValue(const SearchInputParameter(location: 'pontianak'));
  });

  String buildJsonResults() {
    const rawJsonResults = '''
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
        },
        {
            "id": "locality.36711015",
            "type": "Feature",
            "place_type": [
                "locality"
            ],
            "relevance": 1,
            "properties": {
                "mapbox_id": "dXJuOm1ieHBsYzpBakFxWnc"
            },
            "text": "Pontianak Selatan",
            "place_name": "Pontianak Selatan, Pontianak, West Kalimantan, Indonesia",
            "bbox": [
                109.303862,
                -0.081974,
                109.355108,
                -0.025827
            ],
            "center": [
                109.332629,
                -0.045725
            ],
            "geometry": {
                "type": "Point",
                "coordinates": [
                    109.332629,
                    -0.045725
                ]
            },
            "context": [
                {
                    "id": "place.4048999",
                    "wikidata": "Q14168",
                    "mapbox_id": "dXJuOm1ieHBsYzpQY2hu",
                    "text": "Pontianak"
                },
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
        },
        {
            "id": "locality.36702823",
            "type": "Feature",
            "place_type": [
                "locality"
            ],
            "relevance": 1,
            "properties": {
                "mapbox_id": "dXJuOm1ieHBsYzpBakFLWnc"
            },
            "text": "Pontianak Kota",
            "place_name": "Pontianak Kota, Pontianak, West Kalimantan, Indonesia",
            "bbox": [
                109.284971,
                -0.063356,
                109.345774,
                -0.014956
            ],
            "center": [
                109.318568,
                -0.033965
            ],
            "geometry": {
                "type": "Point",
                "coordinates": [
                    109.318568,
                    -0.033965
                ]
            },
            "context": [
                {
                    "id": "place.4048999",
                    "wikidata": "Q14168",
                    "mapbox_id": "dXJuOm1ieHBsYzpQY2hu",
                    "text": "Pontianak"
                },
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
        },
        {
            "id": "locality.36719207",
            "type": "Feature",
            "place_type": [
                "locality"
            ],
            "relevance": 1,
            "properties": {
                "mapbox_id": "dXJuOm1ieHBsYzpBakJLWnc"
            },
            "text": "Pontianak Tenggara",
            "place_name": "Pontianak Tenggara, Pontianak, West Kalimantan, Indonesia",
            "bbox": [
                109.323612,
                -0.097407,
                109.369483,
                -0.041567
            ],
            "center": [
                109.354755,
                -0.063612
            ],
            "geometry": {
                "type": "Point",
                "coordinates": [
                    109.354755,
                    -0.063612
                ]
            },
            "context": [
                {
                    "id": "place.4048999",
                    "wikidata": "Q14168",
                    "mapbox_id": "dXJuOm1ieHBsYzpQY2hu",
                    "text": "Pontianak"
                },
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
        },
        {
            "id": "locality.36694631",
            "type": "Feature",
            "place_type": [
                "locality"
            ],
            "relevance": 1,
            "properties": {
                "wikidata": "Q3700903",
                "mapbox_id": "dXJuOm1ieHBsYzpBaS9xWnc"
            },
            "text": "Pontianak Barat",
            "place_name": "Pontianak Barat, Pontianak, West Kalimantan, Indonesia",
            "bbox": [
                109.272099,
                -0.043475,
                109.334796,
                0.005242
            ],
            "center": [
                109.305513,
                -0.014163
            ],
            "geometry": {
                "type": "Point",
                "coordinates": [
                    109.305513,
                    -0.014163
                ]
            },
            "context": [
                {
                    "id": "place.4048999",
                    "wikidata": "Q14168",
                    "mapbox_id": "dXJuOm1ieHBsYzpQY2hu",
                    "text": "Pontianak"
                },
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
    return rawJsonResults;
  }

  ForwardGeocodingModel buildForwardGeocodingModel() {
    return ForwardGeocodingModel.fromJson(
      json.decode(buildJsonResults()) as Map<String, dynamic>,
    );
  }

  group("Test search location's case", () {
    test(
        'Given the callable class of SearchLocationCase, '
        'When the SearchInputParameter was accepted, '
        'Then it should return the Left of ServerFailure '
        'if the request cannot reach the server.', () async {
      // ARRANGE
      when(
        () => searchLocationCase.call(
          any(that: isA<SearchInputParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, ForwardGeocodingModel>>.value(
          Left(ServerFailure()),
        ),
      );

      // ACT
      final results = await searchLocationCase.call(
        const SearchInputParameter(location: 'pontianak'),
      );

      // ASSERT
      expect(results, isA<Left<Failure, ForwardGeocodingModel>>());
      expect(results, equals(Left(ServerFailure())));
      verify(
        () => searchLocationCase.call(any(that: isA<SearchInputParameter>())),
      );
    });

    test(
        'Given the callable class of SearchLocationCase, '
        'When the SearchInputParameter was accepted, '
        'Then it should return the Left of UnexpectedFailure '
        'if the provided error results was unknown.', () async {
      // ARRANGE
      when(
        () => searchLocationCase.call(
          any(that: isA<SearchInputParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, ForwardGeocodingModel>>.value(
          Left(UnexpectedFailure()),
        ),
      );

      // ACT
      final results = await searchLocationCase.call(
        const SearchInputParameter(location: 'pontianak'),
      );

      // ASSERT
      expect(results, isA<Left<Failure, ForwardGeocodingModel>>());
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => searchLocationCase.call(any(that: isA<SearchInputParameter>())),
      );
    });

    test(
        'Given the callable class of SearchLocationCase, '
        'When the SearchInputParameter was accepted, '
        'Then it should return the Right of ForwardGeocodingModel.', () async {
      // ARRANGE
      when(
        () => searchLocationCase.call(
          any(that: isA<SearchInputParameter>()),
        ),
      ).thenAnswer(
        (_) => Future<Either<Failure, ForwardGeocodingModel>>.value(
          Right(buildForwardGeocodingModel()),
        ),
      );

      // ACT
      final results = await searchLocationCase.call(
        const SearchInputParameter(location: 'pontianak'),
      );

      print(buildForwardGeocodingModel());

      // ASSERT
      expect(results, isA<Right<Failure, ForwardGeocodingModel>>());
      expect(results, equals(Right(buildForwardGeocodingModel())));
      verify(
        () => searchLocationCase.call(any(that: isA<SearchInputParameter>())),
      );
    });
  });
}
