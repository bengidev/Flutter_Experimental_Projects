import 'dart:convert';

import 'package:equatable/equatable.dart';

class HourlyCurrentWeather extends Equatable {
  final double temperature;
  final double windSpeed;
  final double windDirection;
  final int weatherCode;
  final int isDay;
  final String time;

  const HourlyCurrentWeather({
    required this.temperature,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  /// Deserialize the given [json] object into a [HourlyCurrentWeather]
  /// by using the [JsonDecoder] functionality.
  factory HourlyCurrentWeather.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an subtype error.

    var defaultTemperature = 0.0;
    var defaultWindSpeed = 0.0;
    var defaultWindDirection = 0.0;
    var defaultWeatherCode = 0;
    var defaultIsDay = 0;
    var defaultTime = "";

    if (json['temperature'] != null &&
        json['windspeed'] != null &&
        json['winddirection'] != null &&
        json['weathercode'] != null &&
        json['is_day'] != null &&
        json['time'] != null) {
      final jsonTemperature = json['temperature'] as double;
      defaultTemperature = jsonTemperature;

      final jsonWindSpeed = json['windspeed'] as double;
      defaultWindSpeed = jsonWindSpeed;

      final jsonWindDirection = json['winddirection'] as double;
      defaultWindDirection = jsonWindDirection;

      final jsonWeatherCode = json['weathercode'] as int;
      defaultWeatherCode = jsonWeatherCode;

      final jsonIsDay = json['is_day'] as int;
      defaultIsDay = jsonIsDay;

      final jsonTime = json['time'] as String;
      defaultTime = jsonTime;
    }

    return HourlyCurrentWeather(
      temperature: defaultTemperature,
      windSpeed: defaultWindSpeed,
      windDirection: defaultWindDirection,
      weatherCode: defaultWeatherCode,
      isDay: defaultIsDay,
      time: defaultTime,
    );
  }

  /// Return the default value of [HourlyCurrentWeather].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  factory HourlyCurrentWeather.defaultValue() {
    return const HourlyCurrentWeather(
      temperature: 0,
      windSpeed: 0,
      windDirection: 0,
      weatherCode: 0,
      isDay: 0,
      time: "",
    );
  }

  /// Convert this [HourlyCurrentWeather] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'windspeed': windSpeed,
        'winddirection': windDirection,
        'weathercode': weatherCode,
        'is_day': isDay,
        'time': time,
      };

  /// Returns a new object of [HourlyCurrentWeather]
  /// with the same properties as the original,
  /// but with some of the values changed.
  HourlyCurrentWeather copyWith({
    double? temperature,
    double? windSpeed,
    double? windDirection,
    int? weatherCode,
    int? isDay,
    String? time,
  }) {
    return HourlyCurrentWeather(
      temperature: temperature ?? this.temperature,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      weatherCode: weatherCode ?? this.weatherCode,
      isDay: isDay ?? this.isDay,
      time: time ?? this.time,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        temperature,
        windSpeed,
        windDirection,
        weatherCode,
        isDay,
        time,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
