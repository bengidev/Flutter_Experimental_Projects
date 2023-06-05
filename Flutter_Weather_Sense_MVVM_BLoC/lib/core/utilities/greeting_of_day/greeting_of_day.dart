import 'package:flutter/material.dart';

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
  String testGetFromTime({
    required DateTime time,
  }) {
    return GreetingOfDay.getFromTime(time: time);
  }

  /// Generate [String] of [TimeOfDay] status from [DateTime].
  ///
  /// This method will return the default value of "Good Morning"
  /// when the [hasClockTime] is set to be false.
  ///
  static String getFromTime({
    required DateTime time,
    bool hasClockTime = true,
  }) {
    final currentTime = TimeOfDay.fromDateTime(time);
    final greetingResults = _decideGreetingWithinClockRange(
      currentTime.hour,
      hasClockTime: hasClockTime,
    );
    return greetingResults;
  }

  /// Test the [GreetingOfDay]'s private static method
  /// [_decideGreetingWithinClockRange] with the same properties.
  /// This only available for testing purpose only.
  ///
  @visibleForTesting
  String testDecideGreetingWithinClockRange(
    int clockTime, {
    bool hasClockTime = true,
  }) {
    return GreetingOfDay._decideGreetingWithinClockRange(
      clockTime,
      hasClockTime: hasClockTime,
    );
  }

  /// Decide the [_GreetingType]'s description from [clockTime] range.
  ///
  /// This method will return the default value of "Good Morning"
  /// when the [hasClockTime] is set to be false.
  ///
  static String _decideGreetingWithinClockRange(
    int clockTime, {
    bool hasClockTime = true,
  }) {
    // Default value when [hasClockTime] is set to be false.
    if (!hasClockTime) {
      return _GreetingType.morning.description;
    }

    if (clockTime >= 5 && clockTime < 12) {
      return _GreetingType.morning.description;
    } else if (clockTime >= 12 && clockTime < 17) {
      return _GreetingType.afterNoon.description;
    } else {
      return _GreetingType.evening.description;
    }
  }
}
