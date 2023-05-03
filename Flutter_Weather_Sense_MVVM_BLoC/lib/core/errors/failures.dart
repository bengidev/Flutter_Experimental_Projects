import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The base class of all the [Failure] object.
/// This will be the return value when using [Either]
/// for the [Left] position when an [Exception] was thrown.
abstract class Failure extends Equatable {}

/// The [ServerFailure] will return when the
/// status of the [Exception] was relevant to
/// the error of Internet Connection.
class ServerFailure extends Failure {
  final String? message;

  ServerFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

/// The [CacheFailure] will return when the
/// status of the [Exception] was relevant to
/// the error of [SharedPreferences].
class CacheFailure extends Failure {
  final String? message;

  CacheFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

/// The [InvalidInputFailure] will return when the
/// status of the [Exception] was relevant to
/// the error of User Input.
class InvalidInputFailure extends Failure {
  final String? message;

  InvalidInputFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

/// The [UnexpectedFailure] will return when the
/// status of the [Exception] was relevant to
/// the error which the reasons of that error
/// was Unknown.
class UnexpectedFailure extends Failure {
  final String? message;

  UnexpectedFailure({
    this.message,
  });

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [message];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool get stringify => true;
}
