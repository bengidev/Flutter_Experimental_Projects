part of 'daily_weather_forecast_bloc.dart';

/// The base event class of all events inside DailyWeatherForecast feature.
abstract class DailyWeatherForecastEvent extends Equatable {
  const DailyWeatherForecastEvent();
}

/// The implementation of [DailyWeatherForecastEvent] which will
/// execute the [FindDailyWeatherForecastEvent]
/// inside the [DailyWeatherForecastBloc].
///
/// This event requires [latitude] and [longitude] which will
/// be used to send the request for
/// finding the latest daily weather forecast based on
/// [latitude] and [longitude] coordinates.
class FindDailyWeatherForecastEvent extends DailyWeatherForecastEvent {
  final double latitude;
  final double longitude;

  const FindDailyWeatherForecastEvent({
    required this.latitude,
    required this.longitude,
  });

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
