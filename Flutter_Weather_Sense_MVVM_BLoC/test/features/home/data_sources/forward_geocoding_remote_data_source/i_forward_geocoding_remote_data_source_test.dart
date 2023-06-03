import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIForwardGeocodingRemoteDataSource extends Mock
    implements IForwardGeocodingRemoteDataSource {}

void main() async {
  late IForwardGeocodingRemoteDataSource iForwardGeocodingRemoteDataSource;
  setUp(() {
    iForwardGeocodingRemoteDataSource = MockIForwardGeocodingRemoteDataSource();
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

  ForwardGeocodingModel buildMockForwardGeocodingModel() {
    return const ForwardGeocodingModel(
      type: '',
      queries: <String>[],
      features: <ForwardFeature>[],
      attribution: '',
    );
  }

  group('Test the base class of IForwardGeocodingRemoteDataSource', () {
    test(
        'Given the instance of IForwardGeocodingRemoteDataSource, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of ForwardGeocodingModel.', () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenAnswer(
        (_) async => buildMockForwardGeocodingModel(),
      );

      // ACT
      final getSearchResults =
          await iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(getSearchResults, isA<ForwardGeocodingModel>());
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of IForwardGeocodingRemoteDataSource, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenThrow(const ServerException());

      // ACT
      final getSearchResults =
          iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation;

      // ASSERT
      expect(
        () => getSearchResults(location: 'pontianak'),
        throwsA(isA<ServerException>()),
      );
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of IForwardGeocodingRemoteDataSource, '
        'When the method of getSearchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should throw the UnexpectedException '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenThrow(const UnexpectedException());

      // ACT
      final getSearchResults =
          iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation;

      // ASSERT
      expect(
        () => getSearchResults(location: 'pontianak'),
        throwsA(isA<UnexpectedException>()),
      );
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });
  });
}
