// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint("onEventBloc -> [${bloc.runtimeType}] || [$event]");
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint("onChangeBloc -> [${bloc.runtimeType}] || [$change]");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint("onTransitionBloc -> [${bloc.runtimeType}] || [$transition]");
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint("onError(${bloc.runtimeType}, $error, $stackTrace)");
    debugPrint(
      "onErrorBloc -> [${bloc.runtimeType}] || [$error] || [$stackTrace]",
    );
  }
}
