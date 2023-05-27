import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockIForwardGeocodingRepository extends Mock
    implements IForwardGeocodingRepository {}

void main() async {
  late MockIForwardGeocodingRepository iForwardGeocodingRepository;
  setUp(() {
    iForwardGeocodingRepository = MockIForwardGeocodingRepository();
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

  group('Test the base class IForwardGeocodingRepository', () {
    test(
        'Given the instance of IForwardGeocodingRepository, '
        'When the method of searchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of ForwardGeocodingModel Right value',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenAnswer(
        (_) async => Right(buildMockForwardGeocodingModel()),
      );

      // ACT
      final searchResults =
          await iForwardGeocodingRepository.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Right<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of IForwardGeocodingRepository, '
        'When the method of searchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of Failure Left value '
        'if the operation results was failed because of Internet Connection.',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenAnswer(
        (_) async => Left(ServerFailure(message: '404 - Not Found')),
      );

      // ACT
      final searchResults =
          await iForwardGeocodingRepository.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Left<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });

    test(
        'Given the instance of IForwardGeocodingRepository, '
        'When the method of searchGeocodingLocation was accessed '
        'with the valid input parameters, '
        'Then it should return the Future of Failure Left value '
        'if the operation results was failed because of unknown error.',
        () async {
      // ARRANGE
      when(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      ).thenAnswer(
        (_) async => Left(UnexpectedFailure()),
      );

      // ACT
      final searchResults =
          await iForwardGeocodingRepository.searchGeocodingLocation(
        location: "pontianak",
      );

      // ASSERT
      expect(searchResults, isA<Left<Failure, ForwardGeocodingModel>>());
      verify(
        () => iForwardGeocodingRepository.searchGeocodingLocation(
          location: any(named: 'location', that: isA<String>()),
        ),
      );
    });
  });
}
