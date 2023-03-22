import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_concrete_number_trivia_case.dart';

class MockINumberTriviaRepository extends Mock
    implements INumberTriviaRepository {}

void main() {
  late MockINumberTriviaRepository mockINumberTriviaRepository;
  late GetConcreteNumberTriviaCase getConcreteNumberTriviaCase;

  setUp(() {
    mockINumberTriviaRepository = MockINumberTriviaRepository();
    getConcreteNumberTriviaCase =
        GetConcreteNumberTriviaCase(repository: mockINumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test description', number: 1);

  void setUpLeftServerFailure() {
    when(
      () => mockINumberTriviaRepository.getConcreteNumberTrivia(
        number: any(named: 'number'),
      ),
    ).thenAnswer((_) async => Left(ServerFailure()));
  }

  void setUpLeftCacheFailure() {
    when(
      () => mockINumberTriviaRepository.getConcreteNumberTrivia(
        number: any(named: 'number'),
      ),
    ).thenAnswer((_) async => Left(CacheFailure()));
  }

  void setUpRightNumberTrivia() {
    when(
      () => mockINumberTriviaRepository.getConcreteNumberTrivia(
        number: any(named: 'number'),
      ),
    ).thenAnswer((_) async => const Right(tNumberTrivia));
  }

  test(
    'Given the parameter of getConcreteNumberTriviaCase, '
    'When the format data was correct, '
    'Then it should return the right of trivia number object.',
    () async {
      /// ARRANGE
      setUpRightNumberTrivia();

      /// ACT
      final result = await getConcreteNumberTriviaCase(
          const ConcreteParams(number: tNumber));

      /// ASSERT
      expect(result, const Right(tNumberTrivia));
      verify(
        () => mockINumberTriviaRepository.getConcreteNumberTrivia(
          number: any(named: 'number'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockINumberTriviaRepository);
    },
  );

  test(
    'Given the parameter of getConcreteNumberTriviaCase, '
    'When the error from the server was caught, '
    'Then it should return left of server failure.',
    () async {
      /// ARRANGE
      setUpLeftServerFailure();

      /// ACT
      final result = await getConcreteNumberTriviaCase(
          const ConcreteParams(number: tNumber));

      /// ASSERT
      expect(result, Left(ServerFailure()));
      verify(
        () => mockINumberTriviaRepository.getConcreteNumberTrivia(
          number: any(named: 'number'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockINumberTriviaRepository);
    },
  );

  test(
    'Given the parameter of getConcreteNumberTriviaCase, '
    'When the error from the internal device storage was caught, '
    'Then it should return left of cache failure.',
    () async {
      /// ARRANGE
      setUpLeftCacheFailure();

      /// ACT
      final result = await getConcreteNumberTriviaCase(
          const ConcreteParams(number: tNumber));

      /// ASSERT
      expect(result, Left(CacheFailure()));
      verify(
        () => mockINumberTriviaRepository.getConcreteNumberTrivia(
          number: any(named: 'number'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockINumberTriviaRepository);
    },
  );
}
