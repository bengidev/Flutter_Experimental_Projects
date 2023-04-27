import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

/// Private [Enum] for the ease of use
/// each description of [_GreetingType].
enum _GreetingType {
  morning("Good Morning"),
  afterNoon("Good Afternoon"),
  evening("Good Evening");

  const _GreetingType(this.description);

  final String description;
}

@immutable
class GreetingOfDay {
  /// Test the [GreetingOfDay]'s static method
  /// [getFromTime] with the same properties.
  /// This only available for testing purpose only.
  @visibleForTesting
  Either<Failure, String> testGetFromTime({
    required DateTime time,
  }) {
    return GreetingOfDay.getFromTime(
      time: time,
    );
  }

  /// Generate [String] of [TimeOfDay] status from [DateTime].
  /// [getFromTime] will return [UnexpectedFailure]
  /// when error was occurred.
  static Either<Failure, String> getFromTime({
    required DateTime time,
  }) {
    try {
      final currentTime = TimeOfDay.fromDateTime(time);
      final greetingResults = _decideGreetingWithinClockRange(
        clockTime: currentTime.hour,
      );

      if (greetingResults.isEmpty) {
        return Left(UnexpectedFailure());
      } else {
        return Right(greetingResults);
      }
    } catch (exception) {
      return Left(UnexpectedFailure());
    }
  }

  /// Test the [GreetingOfDay]'s private static method
  /// [_decideGreetingWithinClockRange] with the same properties.
  /// This only available for testing purpose only.
  @visibleForTesting
  String testDecideGreetingWithinClockRange({required int clockTime}) {
    return GreetingOfDay._decideGreetingWithinClockRange(clockTime: clockTime);
  }

  /// Decide the [_GreetingType]'s description from [clockTime] range.
  static String _decideGreetingWithinClockRange({required int clockTime}) {
    if (clockTime >= 5 && clockTime < 12) {
      return _GreetingType.morning.description;
    } else if (clockTime >= 12 && clockTime < 17) {
      return _GreetingType.afterNoon.description;
    } else {
      return _GreetingType.evening.description;
    }
  }
}
