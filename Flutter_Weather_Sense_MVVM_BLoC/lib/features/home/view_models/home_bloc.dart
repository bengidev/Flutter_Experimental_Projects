import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/find_hourly_weather_forecast_case.dart';
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
  final SearchLocationCase? searchLocationCase;
  final FindHourlyWeatherForecastCase? findHourlyWeatherForecastCase;

  HomeBloc({
    this.searchLocationCase,
    this.findHourlyWeatherForecastCase,
  }) : super(const HomeState()) {
    on<SearchGeocodingLocationEvent>(_onSearchGeocodingLocationEvent);
    on<FindHourlyWeatherForecastEvent>(_onFindHourlyWeatherForecastEvent);
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
    if (searchLocationCase != null) {
      final failureOrForwardGeocodingModel =
          await searchLocationCase!.call(parameters);

      // Wait the process extraction to be completed
      // by passing the processed use case and emitter.
      await _eitherFailureOrForwardGeocodingModelState(
        failureOrForwardGeocodingModel,
        emit,
      );
    } else {
      emit(
        state.copyWith(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      );
    }
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

  /// Separate the process execution of [FindHourlyWeatherForecastEvent]
  /// from the super initialization constructor of [HomeBloc].
  ///
  /// This process requires the [FindHourlyWeatherForecastEvent], and
  /// [HomeState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [HomeState]
  /// when the process execution of [FindHourlyWeatherForecastEvent]
  /// was completed.
  Future<void> _onFindHourlyWeatherForecastEvent(
    FindHourlyWeatherForecastEvent event,
    Emitter<HomeState> emit,
  ) async {
    // Emmit the loading status while starting the process.
    emit(state.copyWith(status: HomeBlocStatus.loading));

    // Select the appropriate parameters for the use case.
    final parameters = HourlyWeatherForecastParameter(
      latitude: event.latitude,
      longitude: event.longitude,
    );
    // Pass the selected parameters into the provided use case.
    if (findHourlyWeatherForecastCase != null) {
      final failureOrHourlyWeatherForecastModel =
          await findHourlyWeatherForecastCase!.call(parameters);

      // Wait the process extraction to be completed
      // by passing the processed use case and emitter.
      await _eitherFailureOrHourlyWeatherForecastModelState(
        failureOrHourlyWeatherForecastModel,
        emit,
      );
    } else {
      emit(
        state.copyWith(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      );
    }
  }

  /// Separate the process extraction of [Either<Failure, HourlyWeatherForecastModel>]
  /// from the execution of [FindHourlyWeatherForecastEvent].
  ///
  /// This process requires the [Either<Failure, HourlyWeatherForecastModel>],
  /// and [HomeState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [HomeState]
  /// when the process extraction of [Either<Failure, HourlyWeatherForecastModel>]
  /// was completed.
  Future<void> _eitherFailureOrHourlyWeatherForecastModelState(
    Either<Failure, HourlyWeatherForecastModel>
        failureOrHourlyWeatherForecastModel,
    Emitter<HomeState> emit,
  ) async {
    failureOrHourlyWeatherForecastModel.fold((failure) {
      emit(
        state.copyWith(
          status: HomeBlocStatus.failure,
          failureMessage: failure.toString(),
        ),
      );
    }, (hourlyWeatherForecastModel) {
      emit(
        state.copyWith(
          status: HomeBlocStatus.success,
          hourlyWeatherForecastModel: hourlyWeatherForecastModel,
        ),
      );
    });
  }
}
