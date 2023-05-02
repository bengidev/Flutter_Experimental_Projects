import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_feature.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  late MockHttpClient httpClient;
  late ForwardGeocodingRemoteDataSourceImpl
      forwardGeocodingRemoteDataSourceImpl;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    httpClient = MockHttpClient();
    forwardGeocodingRemoteDataSourceImpl = ForwardGeocodingRemoteDataSourceImpl(
      httpClient: httpClient,
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const ForwardGeocodingModel(
        type: '',
        queries: <String>[],
        features: <ForwardFeature>[],
        attribution: '',
      ),
    );
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

  void setUpMockHttpClientSuccess200() {
    const responseCode = 200;
    final responseResults = http.Response(buildJsonResults(), responseCode);

    when(
      () => httpClient.get(
        any(that: isA<Uri>()),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => responseResults);
  }

  void setUpMockHttpClientFailure404() {
    when(
      () => httpClient.get(
        any(that: isA<Uri>()),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(const ServerException());
  }

  void setUpMockUnexpectedFailure() {
    when(
      () => httpClient.get(
        any(that: isA<Uri>()),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(const UnexpectedException());
  }

  group('Test the implementation class of ForwardGeocodingRemoteDataSourceImpl',
      () {
    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the required instance of HttpClient was accessed, '
        'Then it should verify the interaction of its instance.', () async {
      // ARRANGE
      setUpMockHttpClientSuccess200();

      // ACT
      final getSearchResults =
          await forwardGeocodingRemoteDataSourceImpl.getSearchGeocodingLocation(
        location: 'pontianak',
      );

      // ASSERT
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of ForwardGeocodingModel', () async {
      // ARRANGE
      setUpMockHttpClientSuccess200();

      // ACT
      final getSearchResults =
          await forwardGeocodingRemoteDataSourceImpl.getSearchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(getSearchResults, isA<ForwardGeocodingModel>());
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      setUpMockHttpClientFailure404();

      // ACT
      final getSearchResults =
          forwardGeocodingRemoteDataSourceImpl.getSearchGeocodingLocation;

      // ASSERT
      expect(
        () => getSearchResults(location: 'pontianak'),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      setUpMockUnexpectedFailure();

      // ACT
      final getSearchResults =
          forwardGeocodingRemoteDataSourceImpl.getSearchGeocodingLocation;

      // ASSERT
      expect(
        () => getSearchResults(location: 'pontianak'),
        throwsA(isA<UnexpectedException>()),
      );
      verify(
        () => httpClient.get(
          any(that: isA<Uri>()),
          headers: any(named: 'headers'),
        ),
      );
    });
  });
}
