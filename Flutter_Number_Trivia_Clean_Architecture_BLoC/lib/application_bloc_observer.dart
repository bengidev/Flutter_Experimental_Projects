// coverage:ignore-file

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_project/core/utilities/logger.dart';

class ApplicationBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    useLogger(object: "onEventBloc -> [${bloc.runtimeType}] || [$event]");
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    useLogger(object: "onChangeBloc -> [${bloc.runtimeType}] || [$change]");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    useLogger(
        object: "onTransitionBloc -> [${bloc.runtimeType}] || [$transition]");
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    useLogger(object: "onError(${bloc.runtimeType}, $error, $stackTrace)");
    useLogger(
        object:
            "onErrorBloc -> [${bloc.runtimeType}] || [$error] || [$stackTrace]");
  }
}
