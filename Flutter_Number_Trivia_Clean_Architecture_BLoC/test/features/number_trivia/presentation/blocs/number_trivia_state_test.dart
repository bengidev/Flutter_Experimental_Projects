import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';

void main() {
  const String serverFailureMessage = "Server Failure";
  const String cacheFailureMessage = "Cache Failure";
  const String invalidInputFailureMessage =
      "Invalid Input - The number must be positive integer or zero";

  NumberTrivia mockNumberTrivia() {
    return const NumberTrivia(
      text: 'test description',
      number: 1,
    );
  }

  List<NumberTrivia> mockNumberTriviaRecords() {
    return [
      mockNumberTrivia(),
      mockNumberTrivia(),
      mockNumberTrivia(),
    ];
  }

  String mockFailureMessage() => "Server Failure";

  NumberTriviaState createMockNumberTriviaState({
    NumberTriviaStatus status = NumberTriviaStatus.initial,
    NumberTrivia? trivia,
    List<NumberTrivia>? triviaRecords,
    String? failureMessage,
  }) {
    return NumberTriviaState(
      status: status,
      trivia: trivia,
      triviaRecords: triviaRecords,
      failureMessage: failureMessage,
    );
  }

  group('Testing Number Trivia State', () {
    test(
        'Given the trigger of user input, '
        'When the state was available to being accessed, '
        'Then it should supports value equality of the state itself.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockNumberTriviaState(),
        equals(createMockNumberTriviaState()),
      );
    });

    test(
        'Given the trigger of user input, '
        'When the state was available to being accessed, '
        'Then it should correct the value of copyWith.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockNumberTriviaState().copyWith(),
        equals(createMockNumberTriviaState()),
      );
    });

    test(
        'Given the trigger of user input, '
        'When the state was available to being accessed, '
        'Then it should retains the old value for every parameter if null is provided.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockNumberTriviaState().copyWith(
          status: null,
          trivia: null,
          triviaRecords: null,
          failureMessage: null,
        ),
        equals(createMockNumberTriviaState()),
      );
    });

    test(
        'Given the trigger of user input, '
        'When the state was available to being accessed, '
        'Then it should replaces every non-null parameter.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockNumberTriviaState().copyWith(
          status: NumberTriviaStatus.success,
          trivia: mockNumberTrivia(),
          triviaRecords: mockNumberTriviaRecords(),
          failureMessage: mockFailureMessage(),
        ),
        equals(
          createMockNumberTriviaState(
            status: NumberTriviaStatus.success,
            trivia: mockNumberTrivia(),
            triviaRecords: mockNumberTriviaRecords(),
            failureMessage: mockFailureMessage(),
          ),
        ),
      );
    });
  });
}
