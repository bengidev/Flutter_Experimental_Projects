import 'package:equatable/equatable.dart';

/// UseCase abstract class is used for bridging the different implementations
/// of each purposes.
/// [Params] Object is synonym for Parameters
/// [Results] Object is synonym for Results
abstract class UseCase<Params, Results> {
  Results call(Params parameters);
}

class EmptyParams extends Equatable {
  @override
  List<Object?> get props => [];
}
