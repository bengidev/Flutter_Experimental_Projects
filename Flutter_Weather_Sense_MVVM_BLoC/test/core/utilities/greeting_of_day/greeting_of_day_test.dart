import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockGreetingOfDay extends Mock implements GreetingOfDay {}

void main() {
  late MockGreetingOfDay greetingOfDay;

  setUp(() {
    greetingOfDay = MockGreetingOfDay();
  });

  group("Test greeting of day's class", () {
    test(
        'Given the instance of GreetingOfDay, '
        'When the required parameters of GreetingOfDay is not null, '
        'Then it should return the String of TimeOfDay.', () async {
      // ARRANGE
      when(
        () => greetingOfDay.testGetFromTime(
          time: any(named: 'time', that: isA<DateTime>()),
        ),
      ).thenReturn(const Right("Good Morning"));

      // ACT
      final results = greetingOfDay.testGetFromTime(
        time: DateTime.now(),
      );

      // ASSERT
      expect(results, isA<Right<Failure, String>>());
      expect(results, equals(const Right("Good Morning")));
      verify(
        () => greetingOfDay.testGetFromTime(
          time: any(
            named: 'time',
            that: isA<DateTime>(),
          ),
        ),
      ).called(1);
    });

    test(
        'Given the instance of GreetingOfDay, '
        'When the operation results was null, '
        'Then it should throw UnexpectedException.', () async {
      // ARRANGE
      when(
        () => greetingOfDay.testGetFromTime(
          time: any(named: 'time', that: isA<DateTime>()),
        ),
      ).thenReturn(Left(UnexpectedFailure()));

      // ACT
      final results = greetingOfDay.testGetFromTime(
        time: DateTime.now(),
      );

      // ASSERT
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => greetingOfDay.testGetFromTime(
          time: any(
            named: 'time',
            that: isA<DateTime>(),
          ),
        ),
      ).called(1);
    });

    test(
        'Given the instance of GreetingOfDay, '
        'When the clock time was correct, '
        'Then it should return the Greeting Type description.', () async {
      // ARRANGE
      when(
        () => greetingOfDay.testDecideGreetingWithinClockRange(
          clockTime: any(named: 'clockTime', that: isA<int>()),
        ),
      ).thenReturn(
        "Good Morning",
      );

      // ACT
      final results = greetingOfDay.testDecideGreetingWithinClockRange(
        clockTime: 11,
      );

      // ASSERT
      expect(results, isA<String>());
      expect(results, equals("Good Morning"));
      verify(
        () => greetingOfDay.testDecideGreetingWithinClockRange(
          clockTime: any(named: 'clockTime', that: isA<int>()),
        ),
      ).called(1);
    });
  });
}
