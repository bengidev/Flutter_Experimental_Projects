import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/use_cases/use_cases_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/usecases/find_daily_weather_forecast_case.dart';

part 'daily_weather_forecast_event.dart';
part 'daily_weather_forecast_state.dart';

/// The implementation class of [Bloc] for
/// all bloc activities inside the Daily Weather Forecast feature.
///
/// This [Bloc] will send all the requested events
/// by using the [DailyWeatherForecastEvent], and will receive all
/// the results by tracking the latest [DailyWeatherForecastState].
class DailyWeatherForecastBloc
    extends Bloc<DailyWeatherForecastEvent, DailyWeatherForecastState> {
  final IUseCase<DailyWeatherForecastParameter,
          Future<Either<Failure, DailyWeatherForecastModel>>>?
      findDailyWeatherForecastCase;

  DailyWeatherForecastBloc({this.findDailyWeatherForecastCase})
      : super(const DailyWeatherForecastState()) {
    on<FindDailyWeatherForecastEvent>(_onFindDailyWeatherForecastEvent);
  }

  /// Separate the process extraction of [Either<Failure, DailyWeatherForecastModel>]
  /// from the execution of [FindDailyWeatherForecastEvent].
  ///
  /// This process requires the [Either<Failure, DailyWeatherForecastModel>],
  /// and [DailyWeatherForecastState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [DailyWeatherForecastState]
  /// when the process extraction of [Either<Failure, DailyWeatherForecastModel>]
  /// was completed.
  Future<void> _onFindDailyWeatherForecastEvent(
    FindDailyWeatherForecastEvent event,
    Emitter<DailyWeatherForecastState> emit,
  ) async {
    // Emmit the loading status while starting the process.
    emit(state.copyWith(status: DailyWeatherForecastBlocStatus.loading));

    // Select the appropriate parameters for the use case.
    final parameters = DailyWeatherForecastParameter(
      latitude: event.latitude,
      longitude: event.longitude,
    );
    // Pass the selected parameters into the provided use case.
    if (findDailyWeatherForecastCase != null) {
      final failureOrDailyWeatherForecastModel =
          await findDailyWeatherForecastCase!.call(parameters);

      // Wait the process extraction to be completed
      // by passing the processed use case and emitter.
      await _eitherFailureOrDailyWeatherForecastModelState(
        failureOrDailyWeatherForecastModel,
        emit,
      );
    } else {
      emit(
        state.copyWith(
          status: DailyWeatherForecastBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      );
    }
  }

  /// Separate the process extraction of [Either<Failure, DailyWeatherForecastModel>]
  /// from the execution of [FindDailyWeatherForecastEvent].
  ///
  /// This process requires the [Either<Failure, DailyWeatherForecastModel>],
  /// and [DailyWeatherForecastState] to be used as the [Emitter] for the [Bloc] activity.
  ///
  /// [Emitter] will change and update the results of [HomeState]
  /// when the process extraction of [Either<Failure, DailyWeatherForecastModel>]
  /// was completed.
  Future<void> _eitherFailureOrDailyWeatherForecastModelState(
    Either<Failure, DailyWeatherForecastModel>
        failureOrDailyWeatherForecastModel,
    Emitter<DailyWeatherForecastState> emit,
  ) async {
    failureOrDailyWeatherForecastModel.fold((failure) {
      emit(
        state.copyWith(
          status: DailyWeatherForecastBlocStatus.failure,
          failureMessage: failure.toString(),
        ),
      );
    }, (dailyWeatherForecastModel) {
      emit(
        state.copyWith(
          status: DailyWeatherForecastBlocStatus.success,
          dailyWeatherForecastModel: dailyWeatherForecastModel,
        ),
      );
    });
  }
}
