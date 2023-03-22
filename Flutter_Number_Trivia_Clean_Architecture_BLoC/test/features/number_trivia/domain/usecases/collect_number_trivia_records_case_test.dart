import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/collect_number_trivia_records_case.dart';

class MockINumberTriviaRepository extends Mock
    implements INumberTriviaRepository {}

void main() {
  late MockINumberTriviaRepository mockINumberTriviaRepository;
  late CollectNumberTriviaRecordsCase collectNumberTriviaRecordsCase;

  setUp(() {
    mockINumberTriviaRepository = MockINumberTriviaRepository();
    collectNumberTriviaRecordsCase =
        CollectNumberTriviaRecordsCase(repository: mockINumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test description', number: 1);
  const tNumberTriviaRecords = <NumberTrivia>[
    tNumberTrivia,
    tNumberTrivia,
    tNumberTrivia,
  ];

  void setUpLeftCacheFailure() {
    when(
      () => mockINumberTriviaRepository.collectNumberTriviaRecords(),
    ).thenAnswer((_) async => Left(CacheFailure()));
  }

  void setUpRightNumberTriviaRecords() {
    when(() => mockINumberTriviaRepository.collectNumberTriviaRecords())
        .thenAnswer((_) async => const Right(tNumberTriviaRecords));
  }

  test(
    'Given the empty parameter of collectNumberTriviaRecords, '
    'When the executed procedure has no errors, '
    'Then it should return the right of trivia number records.',
    () async {
      /// ARRANGE
      setUpRightNumberTriviaRecords();

      /// ACT
      final results = await collectNumberTriviaRecordsCase(EmptyParams());

      /// ASSERT
      expect(results, const Right(tNumberTriviaRecords));
      verify(() => mockINumberTriviaRepository.collectNumberTriviaRecords())
          .called(1);
      verifyNoMoreInteractions(mockINumberTriviaRepository);
    },
  );

  test(
    'Given the empty parameter of collectNumberTriviaRecords, '
    'When the executed procedure has errors, '
    'Then it should return the left of cache failure.',
    () async {
      /// ARRANGE
      setUpLeftCacheFailure();

      /// ACT
      final results = await collectNumberTriviaRecordsCase(EmptyParams());

      /// ASSERT
      expect(results, Left(CacheFailure()));
      verify(() => mockINumberTriviaRepository.collectNumberTriviaRecords())
          .called(1);
      verifyNoMoreInteractions(mockINumberTriviaRepository);
    },
  );
}
