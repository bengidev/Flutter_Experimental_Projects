import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class GreetingOfDay {
  /// Generate [String] of [TimeOfDay] status from [DateTime].
  /// [getGreetingFromTime] will throw [UnexpectedException]
  /// when error was occurred.
  Either<Failure, String> getFromTime({
    required BuildContext context,
    required DateTime time,
  }) {
    try {
      final currentTime = TimeOfDay.fromDateTime(time);
      final formattedTime = currentTime.format(context);

      if (formattedTime.isEmpty) {
        return Left(UnexpectedFailure());
      } else {
        return Right(formattedTime);
      }
    } catch (exception) {
      return Left(UnexpectedFailure());
    }
  }
}
