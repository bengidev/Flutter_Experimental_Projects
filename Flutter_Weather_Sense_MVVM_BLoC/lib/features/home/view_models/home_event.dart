part of 'home_bloc.dart';

/// The base event class of all events inside Home feature.
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

/// The implementation of [HomeEvent] which will
/// execute the [SearchGeocodingLocationEvent]
/// inside the [HomeBloc].
///
/// This event requires [location] which will
/// be used to send the request for
/// searching the geocoding location based on
/// required [location].
class SearchGeocodingLocationEvent extends HomeEvent {
  final String location;

  const SearchGeocodingLocationEvent({
    required this.location,
  });

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [location];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}

/// The implementation of [HomeEvent] which will
/// execute the [FindHourlyWeatherForecastEvent]
/// inside the [HomeBloc].
///
/// This event requires [latitude] and [longitude] which will
/// be used to send the request for
/// finding the latest hourly weather forecast based on
/// [latitude] and [longitude] coordinates.
class FindHourlyWeatherForecastEvent extends HomeEvent {
  final double latitude;
  final double longitude;

  const FindHourlyWeatherForecastEvent({
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
