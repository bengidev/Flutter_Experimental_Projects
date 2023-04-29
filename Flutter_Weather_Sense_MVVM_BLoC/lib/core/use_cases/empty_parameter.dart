import 'package:equatable/equatable.dart';

/// The parameter object of the use case's implementation.
/// This will give you the access of empty object
/// with a single use case's parameter.
class EmptyParameter extends Equatable {
  @override
  List<Object?> get props => [];
}
