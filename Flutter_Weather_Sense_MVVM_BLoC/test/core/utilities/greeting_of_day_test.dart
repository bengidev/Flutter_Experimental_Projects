import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockGreetingOfDay extends Mock implements GreetingOfDay {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockGreetingOfDay greetingOfDay;
  late FakeBuildContext buildContext;

  setUp(() {
    greetingOfDay = MockGreetingOfDay();
    buildContext = FakeBuildContext();
  });

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  group("Test greeting of day's class", () {
    test(
        'Given the instance of GreetingOfDay, '
        'When the required parameters of GreetingOfDay is not null, '
        'Then it should return the String of TimeOfDay.', () async {
      // ARRANGE
      when(
        () => greetingOfDay.getFromTime(
          context: any(named: 'context', that: isA<BuildContext>()),
          time: any(named: 'time', that: isA<DateTime>()),
        ),
      ).thenReturn(const Right('3:00pm'));

      // ACT
      final results = greetingOfDay.getFromTime(
        context: buildContext,
        time: DateTime.now(),
      );

      // ASSERT
      expect(results, isA<Right<Failure, String>>());
      verify(
        () => greetingOfDay.getFromTime(
          context: any(named: 'context', that: isA<BuildContext>()),
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
        () => greetingOfDay.getFromTime(
          context: any(named: 'context', that: isA<BuildContext>()),
          time: any(named: 'time', that: isA<DateTime>()),
        ),
      ).thenReturn(Left(UnexpectedFailure()));

      // ACT
      final results = greetingOfDay.getFromTime(
        context: buildContext,
        time: DateTime.now(),
      );

      // ASSERT
      expect(results, equals(Left(UnexpectedFailure())));
      verify(
        () => greetingOfDay.getFromTime(
          context: any(named: 'context', that: isA<BuildContext>()),
          time: any(
            named: 'time',
            that: isA<DateTime>(),
          ),
        ),
      ).called(1);
    });
  });
}
