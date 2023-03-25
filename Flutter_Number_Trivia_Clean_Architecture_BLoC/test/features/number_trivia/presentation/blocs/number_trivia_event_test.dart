import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';

void main() {
  const tNumberString = "1";
  const tParsedNumber = 1;

  group('Testing GetTriviaForConcreteNumberEvent', () {
    test(
        'Given the trigger of user input, '
        'When GetTriviaForConcreteNumberEvent was added, '
        'Then it should supports value equality', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
        equals(
          const GetTriviaForConcreteNumberEvent(numberString: tNumberString),
        ),
      );
    });

    test(
        'Given the trigger of user input, '
        'When GetTriviaForConcreteNumberEvent was added, '
        'Then it should correct the props', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const GetTriviaForConcreteNumberEvent(numberString: tNumberString)
            .props,
        equals(<Object?>[tNumberString]),
      );
    });
  });

  group('Testing GetTriviaForRandomNumberEvent', () {
    test(
        'Given the trigger of user input, '
        'When GetTriviaForRandomNumberEvent was added, '
        'Then it should supports value equality', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        GetTriviaForRandomNumberEvent(),
        equals(
          GetTriviaForRandomNumberEvent(),
        ),
      );
    });

    test(
        'Given the trigger of user input, '
        'When GetTriviaForRandomNumberEvent was added, '
        'Then it should correct the props', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        GetTriviaForRandomNumberEvent().props,
        equals(<Object?>[]),
      );
    });
  });

  group('Testing CollectNumberTriviaRecordsEvent', () {
    test(
        'Given the trigger of user input, '
        'When CollectNumberTriviaRecordsEvent was added, '
        'Then it should supports value equality', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        CollectNumberTriviaRecordsEvent(),
        equals(
          CollectNumberTriviaRecordsEvent(),
        ),
      );
    });

    test(
        'Given the trigger of user input, '
        'When CollectNumberTriviaRecordsEvent was added, '
        'Then it should correct the props', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        CollectNumberTriviaRecordsEvent().props,
        equals(<Object?>[]),
      );
    });
  });
}
