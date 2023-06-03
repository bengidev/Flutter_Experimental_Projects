part of 'daily_weather_forecast_bloc.dart';

/// The enumeration of bloc status which will reflect
/// the current status of [DailyWeatherForecastState].
///
enum DailyWeatherForecastBlocStatus { initial, loading, success, failure }

/// The extension of [DailyWeatherForecastBlocStatus] which will be used
/// for the ease of use while manage the current
/// [DailyWeatherForecastBlocStatus].
///
extension DailyWeatherForecastBlocStatusX on DailyWeatherForecastBlocStatus {
  bool get isInitial => this == DailyWeatherForecastBlocStatus.initial;

  bool get isLoading => this == DailyWeatherForecastBlocStatus.loading;

  bool get isSuccess => this == DailyWeatherForecastBlocStatus.success;

  bool get isFailure => this == DailyWeatherForecastBlocStatus.failure;
}

/// The implementation state class of all states inside DailyWeatherForecast feature.
///
class DailyWeatherForecastState extends Equatable {
  final DailyWeatherForecastBlocStatus status;
  final DailyWeatherForecastModel? dailyWeatherForecastModel;
  final String? failureMessage;

  const DailyWeatherForecastState({
    this.status = DailyWeatherForecastBlocStatus.initial,
    this.dailyWeatherForecastModel,
    this.failureMessage,
  });

  /// Returns a new object of [DailyWeatherForecastState]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ///
  DailyWeatherForecastState copyWith({
    DailyWeatherForecastBlocStatus? status,
    DailyWeatherForecastModel? dailyWeatherForecastModel,
    String? failureMessage,
  }) {
    return DailyWeatherForecastState(
      status: status ?? this.status,
      dailyWeatherForecastModel:
          dailyWeatherForecastModel ?? this.dailyWeatherForecastModel,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  /// The list of properties that will be used to determine
  /// whether two instances are equal.
  ///
  @override
  List<Object?> get props => [
        status,
        dailyWeatherForecastModel,
        failureMessage,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  ///
  @override
  bool get stringify => true;
}
