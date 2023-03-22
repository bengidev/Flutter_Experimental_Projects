import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';

void main() {
  RandomGeneratedTrivia mockRandomGeneratedTrivia() {
    return const RandomGeneratedTrivia(
      text: 'test description',
      number: 1,
    );
  }

  String mockFailureMessage() => "Mock Failure Message";

  RandomGeneratedTriviaState createMockTriviaState({
    RandomGeneratedTriviaStatus status = RandomGeneratedTriviaStatus.initial,
    RandomGeneratedTrivia? trivia,
    String? failureMessage,
  }) {
    return RandomGeneratedTriviaState(
      status: status,
      trivia: trivia,
      failureMessage: failureMessage,
    );
  }

  group('Testing Random Generated Trivia State', () {
    test(
        'Given get random generated trivia use case, '
        'When get random generated trivia event was added, '
        'Then it should supports value equality of the state itself.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockTriviaState(),
        equals(createMockTriviaState()),
      );
    });

    test(
        'Given get random generated trivia use case, '
        'When get random generated trivia event was added, '
        'Then it should correct the props of the state itself.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockTriviaState(
          status: RandomGeneratedTriviaStatus.initial,
          trivia: mockRandomGeneratedTrivia(),
          failureMessage: mockFailureMessage(),
        ).props,
        equals(<Object?>[
          RandomGeneratedTriviaStatus.initial,
          mockRandomGeneratedTrivia(),
          mockFailureMessage(),
        ]),
      );
    });

    test(
        'Given get random generated trivia use case, '
        'When get random generated trivia event was added, '
        'Then it should correct the value of copyWith.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockTriviaState().copyWith(),
        equals(createMockTriviaState()),
      );
    });

    test(
        'Given get random generated trivia use case, '
        'When get random generated trivia event was added, '
        'Then it should retains the old value for every parameter if null is provided.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockTriviaState().copyWith(
          status: null,
          trivia: null,
          failureMessage: null,
        ),
        equals(createMockTriviaState()),
      );
    });

    test(
        'Given get random generated trivia use case, '
        'When get random generated trivia event was added, '
        'Then it should replaces every non-null parameter.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        createMockTriviaState().copyWith(
          status: RandomGeneratedTriviaStatus.success,
          trivia: mockRandomGeneratedTrivia(),
          failureMessage: mockFailureMessage(),
        ),
        equals(
          createMockTriviaState(
            status: RandomGeneratedTriviaStatus.success,
            trivia: mockRandomGeneratedTrivia(),
            failureMessage: mockFailureMessage(),
          ),
        ),
      );
    });
  });
}
