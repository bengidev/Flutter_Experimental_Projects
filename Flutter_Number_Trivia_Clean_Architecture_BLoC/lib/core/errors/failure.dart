import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
