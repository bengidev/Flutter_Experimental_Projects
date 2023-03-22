import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';

void main() {
  group('Testing Random Generated Trivia Event', () {
    test(
        'Given Get Random Generated Trivia Use Case, '
        'When Get Random Generated Trivia Event was added, '
        'Then it should supports value equality', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const GetRandomGeneratedTriviaEvent(),
        equals(const GetRandomGeneratedTriviaEvent()),
      );
    });
  });

  test(
      'Given Get Random Generated Trivia Use Case, '
      'When Get Random Generated Trivia Event was added, '
      'Then it should correct the props', () async {
    // ARRANGE

    // ACT

    // ASSERT
    expect(
      const GetRandomGeneratedTriviaEvent().props,
      equals(<Object?>[]),
    );
  });
}
