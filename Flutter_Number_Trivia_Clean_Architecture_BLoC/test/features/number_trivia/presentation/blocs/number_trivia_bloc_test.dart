import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/collect_number_trivia_records_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_concrete_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_random_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';

class MockGetConcreteNumberTriviaCase extends Mock
    implements GetConcreteNumberTriviaCase {}

class MockGetRandomNumberTriviaCase extends Mock
    implements GetRandomNumberTriviaCase {}

class MockCollectNumberTriviaRecordsCase extends Mock
    implements CollectNumberTriviaRecordsCase {}

class MockInputConverter extends Mock implements InputConverter {}

const tNumberString = "1";
const tParsedNumber = 1;
const tNumberTrivia = NumberTrivia(text: "test description", number: 1);
const tNumberTriviaRecords = <NumberTrivia>[
  tNumberTrivia,
  tNumberTrivia,
  tNumberTrivia,
];

void main() {
  late MockGetConcreteNumberTriviaCase mockGetConcreteNumberTriviaCase;
  late MockGetRandomNumberTriviaCase mockGetRandomNumberTriviaCase;
  late MockCollectNumberTriviaRecordsCase mockCollectNumberTriviaRecordsCase;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTriviaCase = MockGetConcreteNumberTriviaCase();
    mockGetRandomNumberTriviaCase = MockGetRandomNumberTriviaCase();
    mockCollectNumberTriviaRecordsCase = MockCollectNumberTriviaRecordsCase();
    mockInputConverter = MockInputConverter();
  });

  void setUpRightMockInputConverter() {
    when(
      () => mockInputConverter.stringToUnsignedInteger(
        string: tNumberString,
      ),
    ).thenReturn(const Right(tParsedNumber));
  }

  void setUpLeftMockInputConverter() {
    when(
      () => mockInputConverter.stringToUnsignedInteger(
        string: tNumberString,
      ),
    ).thenReturn(Left(InvalidInputFailure()));
  }

  void setUpRightMockGetConcreteNumberTrivia() {
    when(
      () => mockGetConcreteNumberTriviaCase(
        const ConcreteParams(number: tParsedNumber),
      ),
    ).thenAnswer((_) async => const Right(tNumberTrivia));
  }

  void setUpLeftServerFailureMockGetConcreteNumberTrivia() {
    when(
      () => mockGetConcreteNumberTriviaCase(
        const ConcreteParams(number: tParsedNumber),
      ),
    ).thenAnswer((_) async => Left(ServerFailure()));
  }

  void setUpLeftCacheFailureMockGetConcreteNumberTrivia() {
    when(
      () => mockGetConcreteNumberTriviaCase(
        const ConcreteParams(number: tParsedNumber),
      ),
    ).thenAnswer((_) async => Left(CacheFailure()));
  }

  void setUpRightMockGetRandomNumberTrivia() {
    when(() => mockGetRandomNumberTriviaCase(EmptyParams()))
        .thenAnswer((_) async => const Right(tNumberTrivia));
  }

  void setUpLeftServerFailureMockGetRandomNumberTrivia() {
    when(() => mockGetRandomNumberTriviaCase(EmptyParams()))
        .thenAnswer((_) async => Left(ServerFailure()));
  }

  void setUpLeftCacheFailureMockGetRandomNumberTrivia() {
    when(() => mockGetRandomNumberTriviaCase(EmptyParams()))
        .thenAnswer((_) async => Left(CacheFailure()));
  }

  void setUpRightCollectNumberTriviaRecords() {
    when(() => mockCollectNumberTriviaRecordsCase(EmptyParams()))
        .thenAnswer((_) async => const Right(tNumberTriviaRecords));
  }

  void setUpLeftCollectNumberTriviaRecords() {
    when(() => mockCollectNumberTriviaRecordsCase(EmptyParams()))
        .thenAnswer((_) async => Left(CacheFailure()));
  }

  NumberTriviaBloc buildBloc() {
    return NumberTriviaBloc(
      concreteTrivia: mockGetConcreteNumberTriviaCase,
      randomTrivia: mockGetRandomNumberTriviaCase,
      collectTriviaRecords: mockCollectNumberTriviaRecordsCase,
      inputConverter: mockInputConverter,
    );
  }

  group('Testing NumberTriviaBloc constructor', () {
    test(
        'Given NumberTriviaBloc constructor, '
        'When its constructor has no errors, '
        'Then it should works properly.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(buildBloc, returnsNormally);
    });

    test(
        'Given NumberTriviaBloc constructor, '
        'When its constructor has no errors, '
        'Then its initial state should correct.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildBloc().state,
        equals(const NumberTriviaState()),
      );
    });
  });

  group("Testing GetTriviaForConcreteNumberEvent", () {
    test(
        'Given the input number of string, '
        'When it was successfully converted into integer type, '
        'Then it should return the right of integer type.', () async {
      // ARRANGE
      setUpRightMockInputConverter();
      setUpRightMockGetConcreteNumberTrivia();

      // ACT
      buildBloc().add(
        const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
      );
      final convertedResult =
          mockInputConverter.stringToUnsignedInteger(string: tNumberString);

      // ASSERT
      expect(convertedResult, const Right(tParsedNumber));
      verify(
        () => mockInputConverter.stringToUnsignedInteger(
          string: tNumberString,
        ),
      ).called(1);
    });

    test(
        'Given the input number of string, '
        'When it was failed to converted the input number into integer type, '
        'Then it should return the left of InvalidInputFailure.', () async {
      // ARRANGE
      setUpLeftMockInputConverter();
      setUpLeftServerFailureMockGetConcreteNumberTrivia();

      // ACT
      buildBloc().add(
        const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
      );
      final convertedResult =
          mockInputConverter.stringToUnsignedInteger(string: tNumberString);

      // ASSERT
      expect(convertedResult, Left(InvalidInputFailure()));
      verify(
        () => mockInputConverter.stringToUnsignedInteger(
          string: tNumberString,
        ),
      ).called(1);
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input number of string, '
      'When the GetTriviaForConcreteNumberEvent was added, '
      'Then it should return the right of NumberTriviaState with success status.',
      build: buildBloc,
      setUp: () {
        setUpRightMockInputConverter();
        setUpRightMockGetConcreteNumberTrivia();
      },
      act: (bloc) {
        bloc.add(
          const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
        );
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.success,
          trivia: tNumberTrivia,
        ),
      ],
      verify: (bloc) {
        verify(
          () => mockGetConcreteNumberTriviaCase(
            const ConcreteParams(number: tParsedNumber),
          ),
        ).called(1);
        verifyZeroInteractions(mockGetRandomNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input number of string, '
      'When the GetTriviaForConcreteNumberEvent was added, '
      'Then it should return the left of NumberTriviaState with server failure status.',
      build: buildBloc,
      setUp: () {
        setUpRightMockInputConverter();
        setUpLeftServerFailureMockGetConcreteNumberTrivia();
      },
      act: (bloc) {
        bloc.add(
          const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
        );
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.serverFailureMessage,
        ),
      ],
      verify: (bloc) {
        verify(
          () => mockGetConcreteNumberTriviaCase(
            const ConcreteParams(number: tParsedNumber),
          ),
        ).called(1);
        verifyZeroInteractions(mockGetRandomNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input number of string, '
      'When the GetTriviaForConcreteNumberEvent was added, '
      'Then it should return the left of NumberTriviaState with cache failure status.',
      build: buildBloc,
      setUp: () {
        setUpRightMockInputConverter();
        setUpLeftCacheFailureMockGetConcreteNumberTrivia();
      },
      act: (bloc) {
        bloc.add(
          const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
        );
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.cacheFailureMessage,
        ),
      ],
      verify: (bloc) {
        verify(
          () => mockGetConcreteNumberTriviaCase(
            const ConcreteParams(number: tParsedNumber),
          ),
        ).called(1);
        verifyZeroInteractions(mockGetRandomNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );
  });

  group("Testing GetTriviaForRandomNumberEvent", () {
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input of random number, '
      'When the GetTriviaForRandomNumberEvent was added, '
      'Then it should return the right of NumberTriviaState with success status.',
      build: buildBloc,
      setUp: () {
        setUpRightMockGetRandomNumberTrivia();
      },
      act: (bloc) {
        bloc.add(GetTriviaForRandomNumberEvent());
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.success,
          trivia: tNumberTrivia,
        ),
      ],
      verify: (bloc) {
        verify(() => mockGetRandomNumberTriviaCase(EmptyParams())).called(1);
        verifyZeroInteractions(mockGetConcreteNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input of random number, '
      'When the GetTriviaForRandomNumberEvent was added, '
      'Then it should return the left of NumberTriviaState with server failure status.',
      build: buildBloc,
      setUp: () {
        setUpLeftServerFailureMockGetRandomNumberTrivia();
      },
      act: (bloc) {
        bloc.add(GetTriviaForRandomNumberEvent());
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.serverFailureMessage,
        ),
      ],
      verify: (bloc) {
        verify(() => mockGetRandomNumberTriviaCase(EmptyParams())).called(1);
        verifyZeroInteractions(mockGetConcreteNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the input of random number, '
      'When the GetTriviaForRandomNumberEvent was added, '
      'Then it should return the left of NumberTriviaState with cache failure status.',
      build: buildBloc,
      setUp: () {
        setUpLeftCacheFailureMockGetRandomNumberTrivia();
      },
      act: (bloc) {
        bloc.add(GetTriviaForRandomNumberEvent());
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.cacheFailureMessage,
        ),
      ],
      verify: (bloc) {
        verify(() => mockGetRandomNumberTriviaCase(EmptyParams())).called(1);
        verifyZeroInteractions(mockGetConcreteNumberTriviaCase);
        verifyZeroInteractions(mockCollectNumberTriviaRecordsCase);
      },
    );
  });

  group("Testing CollectNumberTriviaRecordsEvent", () {
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the trigger of user input, '
      'When the CollectNumberTriviaRecordsEvent was added, '
      'Then it should return the right of NumberTriviaState records with success status.',
      build: buildBloc,
      setUp: () {
        setUpRightCollectNumberTriviaRecords();
      },
      act: (bloc) {
        bloc.add(CollectNumberTriviaRecordsEvent());
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.success,
          triviaRecords: tNumberTriviaRecords,
        ),
      ],
      verify: (bloc) {
        verify(() => mockCollectNumberTriviaRecordsCase(EmptyParams()))
            .called(1);
        verifyZeroInteractions(mockGetConcreteNumberTriviaCase);
        verifyZeroInteractions(mockGetRandomNumberTriviaCase);
      },
    );
    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'Given the trigger of user input, '
      'When the CollectNumberTriviaRecordsEvent was added, '
      'Then it should return the left of NumberTriviaState with cache failure status.',
      build: buildBloc,
      setUp: () {
        setUpLeftCollectNumberTriviaRecords();
      },
      act: (bloc) {
        bloc.add(CollectNumberTriviaRecordsEvent());
      },
      expect: () => [
        const NumberTriviaState(status: NumberTriviaStatus.loading),
        const NumberTriviaState(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.cacheFailureMessage,
        ),
      ],
      verify: (bloc) {
        verify(() => mockCollectNumberTriviaRecordsCase(EmptyParams()))
            .called(1);
        verifyZeroInteractions(mockGetConcreteNumberTriviaCase);
        verifyZeroInteractions(mockGetRandomNumberTriviaCase);
      },
    );
  });
}
