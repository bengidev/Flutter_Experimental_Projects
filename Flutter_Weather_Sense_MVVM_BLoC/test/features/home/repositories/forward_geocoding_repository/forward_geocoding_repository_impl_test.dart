import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository/forward_geocoding_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockIForwardGeocodingRemoteDataSource extends Mock
    implements IForwardGeocodingRemoteDataSource {}

void main() async {
  late MockIForwardGeocodingRemoteDataSource iForwardGeocodingRemoteDataSource;
  late ForwardGeocodingRepositoryImpl forwardGeocodingRepositoryImpl;

  setUp(() {
    iForwardGeocodingRemoteDataSource = MockIForwardGeocodingRemoteDataSource();
    forwardGeocodingRepositoryImpl = ForwardGeocodingRepositoryImpl(
      remoteDataSource: iForwardGeocodingRemoteDataSource,
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

  ForwardGeocodingModel buildMockForwardGeocodingModel() {
    return const ForwardGeocodingModel(
      type: '',
      queries: <String>[],
      features: <ForwardFeature>[],
      attribution: '',
    );
  }

  group('Test the implementation class ForwardGeocodingRepositoryImpl', () {
    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the required instance of IForwardGeocodingRemoteDataSource was accessed, '
        'Then it should verify the interaction of its instance.', () async {
      // ARRANGE

      // ACT
      final searchResults =
          await forwardGeocodingRepositoryImpl.searchGeocodingLocation(
        location: 'pontianak',
      );

      // ASSERT
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of searchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of ForwardGeocodingModel object',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenAnswer(
        (_) async => buildMockForwardGeocodingModel(),
      );

      // ACT
      final searchResults =
          await forwardGeocodingRepositoryImpl.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Right<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of searchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should throw the ServerException '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenThrow(const ServerException(message: '404 - Not Found'));

      // ACT
      final searchResults =
          await forwardGeocodingRepositoryImpl.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Left<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of ForwardGeocodingRepositoryImpl, '
        'When the method of searchGeocodingLocation was accessed '
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
      final searchResults =
          await forwardGeocodingRepositoryImpl.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Left<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRemoteDataSource.getSearchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });
  });
}
