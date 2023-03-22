import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/domain/repositories/i_random_generated_trivia_repository.dart';
import 'package:number_trivia_project/features/home/domain/usecases/get_random_generated_trivia_case.dart';

class MockIRandomGeneratedTriviaRepository extends Mock
    implements IRandomGeneratedTriviaRepository {}

void main() {
  late MockIRandomGeneratedTriviaRepository mockIRandomTriviaRepository;
  late GetRandomGeneratedTriviaCase getRandomGeneratedTriviaCase;

  setUp(() {
    mockIRandomTriviaRepository = MockIRandomGeneratedTriviaRepository();
    getRandomGeneratedTriviaCase = GetRandomGeneratedTriviaCase(
      repository: mockIRandomTriviaRepository,
    );
  });

  const tRandomGeneratedTrivia = RandomGeneratedTrivia(
    text: "test description",
    number: 1,
  );

  group('Testing get random generated trivia use case', () {
    test(
        'Given value of get random generated trivia use case, '
        'When random trivia repository has no errors, '
        'Then it should return Right of Random Generated Trivia Entity.',
        () async {
      // ARRANGE
      when(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .thenAnswer((_) async => const Right(tRandomGeneratedTrivia));

      // ACT
      final result = await getRandomGeneratedTriviaCase.call(EmptyParams());

      // ASSERT
      expect(result, const Right(tRandomGeneratedTrivia));
      verify(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .called(1);
      verifyNoMoreInteractions(mockIRandomTriviaRepository);
    });

    test(
        'Given value of get random generated trivia use case, '
        'When random trivia repository has erros of Server Exception, '
        'Then it should return Left of ServerFailure.', () async {
      // ARRANGE
      when(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .thenAnswer((_) async => Left(ServerFailure()));

      // ACT
      final result = await getRandomGeneratedTriviaCase.call(EmptyParams());

      // ASSERT
      expect(result, Left(ServerFailure()));
      verify(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .called(1);
      verifyNoMoreInteractions(mockIRandomTriviaRepository);
    });

    test(
        'Given value of get random generated trivia use case, '
        'When random trivia repository has erros of Cache Exception, '
        'Then it should return Left of Cache Failure.', () async {
      // ARRANGE
      when(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .thenAnswer((_) async => Left(CacheFailure()));

      // ACT
      final result = await getRandomGeneratedTriviaCase.call(EmptyParams());

      // ASSERT
      expect(result, Left(CacheFailure()));
      verify(() => mockIRandomTriviaRepository.getRandomGeneratedTrivia())
          .called(1);
      verifyNoMoreInteractions(mockIRandomTriviaRepository);
    });
  });
}
