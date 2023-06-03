import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyUnits extends Equatable {
  final String time;
  final String weatherCode;
  final String temperature2MMax;
  final String temperature2MMin;
  final String sunrise;
  final String sunset;
  final String precipitationProbabilityMax;
  final String windSpeed10MMax;

  const DailyUnits({
    required this.time,
    required this.weatherCode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.sunrise,
    required this.sunset,
    required this.precipitationProbabilityMax,
    required this.windSpeed10MMax,
  });

  /// Deserialize the given [json] object into a [DailyUnits]
  /// by using the [JsonDecoder] functionality.
  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an subtype error.

    var defaultTime = "";
    var defaultWeatherCode = "";
    var defaultTemperature2MMax = "";
    var defaultTemperature2MMin = "";
    var defaultSunrise = "";
    var defaultSunset = "";
    var defaultPrecipitationProbabilityMax = "";
    var defaultWindSpeed10MMax = "";

    if (json['time'] != null &&
        json['weathercode'] != null &&
        json['temperature_2m_max'] != null &&
        json['temperature_2m_min'] != null &&
        json['sunrise'] != null &&
        json['sunset'] != null &&
        json['precipitation_probability_max'] != null &&
        json['windspeed_10m_max'] != null) {
      final jsonTime = json['time'] as String;
      defaultTime = jsonTime;

      final jsonWeatherCode = json['weathercode'] as String;
      defaultWeatherCode = jsonWeatherCode;

      final jsonTemperature2MMax = json['temperature_2m_max'] as String;
      defaultTemperature2MMax = jsonTemperature2MMax;

      final jsonTemperature2MMin = json['temperature_2m_min'] as String;
      defaultTemperature2MMin = jsonTemperature2MMin;

      final jsonSunrise = json['sunrise'] as String;
      defaultSunrise = jsonSunrise;

      final jsonSunset = json['sunset'] as String;
      defaultSunset = jsonSunset;

      final jsonPrecipitationProbabilityMax =
          json['precipitation_probability_max'] as String;
      defaultPrecipitationProbabilityMax = jsonPrecipitationProbabilityMax;

      final jsonWindSpeed10MMax = json['windspeed_10m_max'] as String;
      defaultWindSpeed10MMax = jsonWindSpeed10MMax;
    }

    return DailyUnits(
      time: defaultTime,
      weatherCode: defaultWeatherCode,
      temperature2MMax: defaultTemperature2MMax,
      temperature2MMin: defaultTemperature2MMin,
      sunrise: defaultSunrise,
      sunset: defaultSunset,
      precipitationProbabilityMax: defaultPrecipitationProbabilityMax,
      windSpeed10MMax: defaultWindSpeed10MMax,
    );
  }

  /// Return the default value of [DailyUnits].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  ///
  factory DailyUnits.defaultValue() {
    return const DailyUnits(
      time: "",
      weatherCode: "",
      temperature2MMax: "",
      temperature2MMin: "",
      sunrise: "",
      sunset: "",
      precipitationProbabilityMax: "",
      windSpeed10MMax: "",
    );
  }

  /// Convert this [DailyUnits] into a [json] object
  /// by using the [JsonEncoder] functionality.
  ///
  Map<String, dynamic> toJson() => {
        'time': time,
        'weathercode': weatherCode,
        'temperature_2m_max': temperature2MMax,
        'temperature_2m_min': temperature2MMin,
        'sunrise': sunrise,
        'sunset': sunset,
        'precipitation_probability_max': precipitationProbabilityMax,
        'windspeed_10m_max': windSpeed10MMax,
      };

  /// Returns a new object of [DailyUnits]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ///
  DailyUnits copyWith({
    String? time,
    String? weatherCode,
    String? temperature2MMax,
    String? temperature2MMin,
    String? sunrise,
    String? sunset,
    String? precipitationProbabilityMax,
    String? windSpeed10MMax,
  }) {
    return DailyUnits(
      time: time ?? this.time,
      weatherCode: weatherCode ?? this.weatherCode,
      temperature2MMax: temperature2MMax ?? this.temperature2MMax,
      temperature2MMin: temperature2MMin ?? this.temperature2MMin,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      precipitationProbabilityMax:
          precipitationProbabilityMax ?? this.precipitationProbabilityMax,
      windSpeed10MMax: windSpeed10MMax ?? this.windSpeed10MMax,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  ///
  @override
  List<Object?> get props => [
        time,
        weatherCode,
        temperature2MMax,
        temperature2MMin,
        sunrise,
        sunset,
        precipitationProbabilityMax,
        windSpeed10MMax,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true].
  ///
  @override
  bool? get stringify => true;
}
