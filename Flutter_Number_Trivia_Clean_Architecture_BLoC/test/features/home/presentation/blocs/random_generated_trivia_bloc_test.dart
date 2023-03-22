import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/domain/usecases/get_random_generated_trivia_case.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';

class MockGetRandomGeneratedTriviaUseCase extends Mock
    implements GetRandomGeneratedTriviaCase {}

void main() {
  late MockGetRandomGeneratedTriviaUseCase mockGetRandomGeneratedTriviaUseCase;

  setUpAll(() {
    registerFallbackValue(EmptyParams());
  });

  setUp(() {
    mockGetRandomGeneratedTriviaUseCase = MockGetRandomGeneratedTriviaUseCase();
  });

  const tRandomGeneratedTrivia =
      RandomGeneratedTrivia(text: "test description", number: 1);

  RandomGeneratedTriviaBloc buildRandomGeneratedTriviaBloc() {
    return RandomGeneratedTriviaBloc(
      useCase: mockGetRandomGeneratedTriviaUseCase,
    );
  }

  group('Testing Get Random Generated Trivia Bloc', () {
    test(
        'Given empty use case, '
        'When empty event was added, '
        'Then it should works properly.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(buildRandomGeneratedTriviaBloc, returnsNormally);
    });

    test(
        'Given empty use case, '
        'When empty event was added, '
        'Then it should equals random generated trivia state.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildRandomGeneratedTriviaBloc().state,
        equals(const RandomGeneratedTriviaState()),
      );
    });

    blocTest<RandomGeneratedTriviaBloc, RandomGeneratedTriviaState>(
      'Given get random generated trivia use case that returns right, '
      'When get random generated trivia event was added, '
      'Then it should emit random generated trivia state of success .',
      setUp: () {
        when(() => mockGetRandomGeneratedTriviaUseCase.call(any()))
            .thenAnswer((_) async => const Right(tRandomGeneratedTrivia));
      },
      build: () => buildRandomGeneratedTriviaBloc(),
      seed: () => const RandomGeneratedTriviaState(
        status: RandomGeneratedTriviaStatus.initial,
      ),
      act: (bloc) {
        bloc.add(const GetRandomGeneratedTriviaEvent());
      },
      expect: () => <RandomGeneratedTriviaState>[
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.loading,
        ),
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.success,
          trivia: tRandomGeneratedTrivia,
        )
      ],
      verify: (bloc) {
        verify(
          () => mockGetRandomGeneratedTriviaUseCase
              .call(any(that: isA<EmptyParams>())),
        ).called(1);
      },
    );

    blocTest<RandomGeneratedTriviaBloc, RandomGeneratedTriviaState>(
      'Given get random generated trivia use case that returns left, '
      'When get random generated trivia event was added, '
      'Then it should emit random generated trivia state of server failure .',
      setUp: () {
        when(() => mockGetRandomGeneratedTriviaUseCase.call(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => buildRandomGeneratedTriviaBloc(),
      seed: () => const RandomGeneratedTriviaState(
        status: RandomGeneratedTriviaStatus.initial,
      ),
      act: (bloc) {
        bloc.add(const GetRandomGeneratedTriviaEvent());
      },
      expect: () => <RandomGeneratedTriviaState>[
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.loading,
        ),
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.failure,
          failureMessage: "ServerFailure",
        )
      ],
      verify: (bloc) {
        verify(
          () => mockGetRandomGeneratedTriviaUseCase
              .call(any(that: isA<EmptyParams>())),
        ).called(1);
      },
    );

    blocTest<RandomGeneratedTriviaBloc, RandomGeneratedTriviaState>(
      'Given get random generated trivia use case that returns left, '
      'When get random generated trivia event was added, '
      'Then it should emit random generated trivia state of cache failure .',
      setUp: () {
        when(() => mockGetRandomGeneratedTriviaUseCase.call(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      build: () => buildRandomGeneratedTriviaBloc(),
      seed: () => const RandomGeneratedTriviaState(
        status: RandomGeneratedTriviaStatus.initial,
      ),
      act: (bloc) {
        bloc.add(const GetRandomGeneratedTriviaEvent());
      },
      expect: () => <RandomGeneratedTriviaState>[
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.loading,
        ),
        const RandomGeneratedTriviaState(
          status: RandomGeneratedTriviaStatus.failure,
          failureMessage: "CacheFailure",
        )
      ],
      verify: (bloc) {
        verify(
          () => mockGetRandomGeneratedTriviaUseCase
              .call(any(that: isA<EmptyParams>())),
        ).called(1);
      },
    );
  });
}
