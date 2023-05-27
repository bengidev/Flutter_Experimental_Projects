part of 'home_bloc.dart';

/// The enumeration of bloc status which will reflect
/// the current status of [HomeState].
enum HomeBlocStatus { initial, loading, success, failure }

/// The extension of [HomeBlocStatus] which will be used
/// for the ease of use while manage the current
/// [HomeBlocStatus].
extension HomeBlocStatusX on HomeBlocStatus {
  bool get isInitial => this == HomeBlocStatus.initial;

  bool get isLoading => this == HomeBlocStatus.loading;

  bool get isSuccess => this == HomeBlocStatus.success;

  bool get isFailure => this == HomeBlocStatus.failure;
}

/// The implementation state class of all states inside Home feature.
class HomeState extends Equatable {
  final HomeBlocStatus status;
  final ForwardGeocodingModel? forwardGeocodingModel;
  final HourlyWeatherForecastModel? hourlyWeatherForecastModel;
  final String? failureMessage;

  const HomeState({
    this.status = HomeBlocStatus.initial,
    this.forwardGeocodingModel,
    this.hourlyWeatherForecastModel,
    this.failureMessage,
  });

  /// Returns a new object of [HomeState]
  /// with the same properties as the original,
  /// but with some of the values changed.
  HomeState copyWith({
    HomeBlocStatus? status,
    ForwardGeocodingModel? forwardGeocodingModel,
    HourlyWeatherForecastModel? hourlyWeatherForecastModel,
    String? failureMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      forwardGeocodingModel:
          forwardGeocodingModel ?? this.forwardGeocodingModel,
      hourlyWeatherForecastModel:
          hourlyWeatherForecastModel ?? this.hourlyWeatherForecastModel,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        status,
        forwardGeocodingModel,
        hourlyWeatherForecastModel,
        failureMessage,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
