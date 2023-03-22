import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/usecases/usecase.dart';
import 'package:number_trivia_project/core/utilities/input_converter.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_concrete_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_random_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetConcreteNumberTriviaCase>()])
@GenerateNiceMocks([MockSpec<GetRandomNumberTriviaCase>()])
@GenerateNiceMocks([MockSpec<InputConverter>()])
void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
        concreteTrivia: mockGetConcreteNumberTrivia,
        randomTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  const tNumberString = "1";
  const tNumberParsed = 1;
  const tNumberTrivia = NumberTrivia(text: "test trivia", number: 1);

  void setUpMockInputConverterSuccess() {
    when(mockInputConverter.stringToUnsignedInteger(str: anyNamed("str")))
        .thenReturn(const Right(tNumberParsed));
  }

  void setUpMockGetConcreteNumberTriviaSuccess() {
    when(mockGetConcreteNumberTrivia.call(any))
        .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
  }

  void setUpMockGetRandomNumberTriviaSuccess() {
    when(mockGetRandomNumberTrivia.call(any))
        .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
  }

  test(
    "Should check when initialState of NumberTriviaBloc is NumberTriviaEmpty",
    () async {
      expect(numberTriviaBloc.state, equals(NumberTriviaEmptyState()));
      // Assert
    },
  );

  group("GetTriviaForConcreteNumberEvent", () {
    test(
      "Should call the InputConverter to validate and convert "
      "the string to an unsigned integer",
      () async {
        // Arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        await untilCalled(
            mockInputConverter.stringToUnsignedInteger(str: anyNamed("str")));
        // Assert
        verify(mockInputConverter.stringToUnsignedInteger(str: tNumberString));
      },
    );

    test(
      "Should emit [NumberTriviaErrorState] when the input is invalid",
      () async {
        // Arrange
        when(mockInputConverter.stringToUnsignedInteger(str: anyNamed("str")))
            .thenReturn(Left(InvalidInputFailure()));
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        // Assert
        final expected = [
          const NumberTriviaErrorState(
              message: NumberTriviaBloc.invalidInputFailureMessage)
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );

    test(
      "Should get the data from the concrete use case",
      () async {
        // Arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia.call(any));
        // Assert
        verify(mockGetConcreteNumberTrivia
            .call(const ConcreteParams(number: tNumberParsed)));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaLoadedState] "
      "when the data is gotten successfully",
      () async {
        // Arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaLoadedState(trivia: tNumberTrivia),
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaErrorState] "
      "when getting data fails",
      () async {
        // Arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaErrorState(
              message: NumberTriviaBloc.serverFailureMessage)
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaErrorState] "
      "with a proper message for the error when getting data fails",
      () async {
        // Arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((realInvocation) async => Left(CacheFailure()));
        // Act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaErrorState(
              message: NumberTriviaBloc.cacheFailureMessage)
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );
  });

  group("GetTriviaForRandomNumberEvent", () {
    test(
      "Should get the data from the random use case",
      () async {
        // Arrange
        setUpMockGetRandomNumberTriviaSuccess();
        // Act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
        await untilCalled(mockGetRandomNumberTrivia.call(any));
        // Assert
        verify(mockGetRandomNumberTrivia.call(EmptyParams()));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaLoadedState] "
      "when the data is gotten successfully",
      () async {
        // Arrange
        setUpMockGetRandomNumberTriviaSuccess();
        // Act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaLoadedState(trivia: tNumberTrivia),
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaErrorState] "
      "when getting data fails",
      () async {
        // Arrange
        setUpMockGetRandomNumberTriviaSuccess();
        when(mockGetRandomNumberTrivia.call(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        // Act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaErrorState(
              message: NumberTriviaBloc.serverFailureMessage)
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );

    test(
      "Should emit [NumberTriviaLoadingState, NumberTriviaErrorState] "
      "with a proper message for the error when getting data fails",
      () async {
        // Arrange
        setUpMockGetRandomNumberTriviaSuccess();
        when(mockGetRandomNumberTrivia.call(any))
            .thenAnswer((realInvocation) async => Left(CacheFailure()));
        // Act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
        // Assert
        final expected = [
          NumberTriviaLoadingState(),
          const NumberTriviaErrorState(
              message: NumberTriviaBloc.cacheFailureMessage)
        ];
        expectLater(numberTriviaBloc.stream, emitsInOrder(expected));
      },
    );
  });
}
