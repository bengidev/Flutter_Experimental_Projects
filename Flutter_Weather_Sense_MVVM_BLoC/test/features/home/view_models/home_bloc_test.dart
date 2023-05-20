import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchLocationCase extends Mock implements SearchLocationCase {}

void main() async {
  late MockSearchLocationCase searchLocationCase;

  setUp(() {
    searchLocationCase = MockSearchLocationCase();
  });

  HomeBloc buildHomeBloc() {
    return HomeBloc(searchLocationCase: searchLocationCase);
  }

  ForwardGeocodingModel mockForwardGeocodingModel() {
    return const ForwardGeocodingModel(
      type: '',
      queries: <String>[],
      features: <ForwardFeature>[],
      attribution: '',
    );
  }

  group('Testing HomeBloc constructor', () {
    test(
        'Given the instance of HomeBloc, '
        'When its constructor has no errors, '
        'Then it should works properly.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(buildHomeBloc, returnsNormally);
    });

    test(
        'Given the instance of HomeBloc, '
        'When its constructor has no errors, '
        'Then its initial state should correct.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildHomeBloc().state,
        equals(const HomeState()),
      );
    });
  });

  group("Testing to add the SearchGeocodingLocationEvent", () {
    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the right of HomeState with success status.',
      build: buildHomeBloc,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Right(mockForwardGeocodingModel()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.success,
          forwardGeocodingModel: mockForwardGeocodingModel(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the left of ServerFailure '
      'with the server exception status.',
      build: buildHomeBloc,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: ServerFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildHomeBloc,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Left(UnexpectedFailure()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );
  });
}
