import 'package:flutter/foundation.dart';

/// [IUseCase] is used for bridging the different implementations
/// of each purposes.
/// [Parameters] Object is synonym for Parameters
/// [Results] Object is synonym for Results
///
@immutable
abstract class IUseCase<Parameters, Results> {
  Results call(Parameters parameters);
}
