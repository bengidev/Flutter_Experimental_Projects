import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_input_parameter.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case.dart';

part 'home_event.dart';
part 'home_state.dart';

/// The implementation class of [Bloc] for
/// all bloc activities inside the Home feature.
///
/// This [Bloc] will send all the requested events
/// by using the [HomeEvent], and will receive all
/// the results by tracking the latest [HomeState].
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SearchLocationCase searchLocationCase;

  HomeBloc({
    required this.searchLocationCase,
  }) : super(const HomeState()) {
    on<SearchGeocodingLocationEvent>(_onSearchGeocodingLocationEvent);
  }

  /// Separate the process execution of [SearchGeocodingLocationEvent]
  /// from the super initialization constructor of [HomeBloc].
  ///
  /// This process requires the [SearchGeocodingLocationEvent], and
  /// [HomeState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [HomeState]
  /// when the process execution of [SearchGeocodingLocationEvent]
  /// was completed.
  Future<void> _onSearchGeocodingLocationEvent(
    SearchGeocodingLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Emmit the loading status while starting the process.
    emit(state.copyWith(status: HomeBlocStatus.loading));

    // Select the appropriate parameters for the use case.
    final parameters = SearchInputParameter(location: event.location);
    // Pass the selected parameters into the provided use case.
    final failureOrForwardGeocodingModel = await searchLocationCase(parameters);

    // Wait the process extraction to be completed
    // by passing the processed use case and emitter.
    await _eitherFailureOrForwardGeocodingModelState(
      failureOrForwardGeocodingModel,
      emit,
    );
  }

  /// Separate the process extraction of [Either<Failure, ForwardGeocodingModel>]
  /// from the execution of [SearchGeocodingLocationEvent].
  ///
  /// This process requires the [Either<Failure, ForwardGeocodingModel>],
  /// and [HomeState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [HomeState]
  /// when the process extraction of [Either<Failure, ForwardGeocodingModel>]
  /// was completed.
  Future<void> _eitherFailureOrForwardGeocodingModelState(
    Either<Failure, ForwardGeocodingModel> failureOrForwardGeocodingModel,
    Emitter<HomeState> emit,
  ) async {
    failureOrForwardGeocodingModel.fold((failure) {
      emit(
        state.copyWith(
          status: HomeBlocStatus.failure,
          failureMessage: failure.toString(),
        ),
      );
    }, (forwardGeocodingModel) {
      emit(
        state.copyWith(
          status: HomeBlocStatus.success,
          forwardGeocodingModel: forwardGeocodingModel,
        ),
      );
    });
  }
}
