import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class CacheException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}
