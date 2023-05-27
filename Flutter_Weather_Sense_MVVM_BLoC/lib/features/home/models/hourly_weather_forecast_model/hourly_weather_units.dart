import 'dart:convert';

import 'package:equatable/equatable.dart';

class HourlyWeatherUnits extends Equatable {
  final String time;
  final String temperature2M;
  final String relativeHumidity2M;
  final String dewPoint2M;
  final String apparentTemperature;
  final String precipitationProbability;
  final String weatherCode;
  final String surfacePressure;
  final String visibility;
  final String windSpeed10M;

  const HourlyWeatherUnits({
    required this.time,
    required this.temperature2M,
    required this.relativeHumidity2M,
    required this.dewPoint2M,
    required this.apparentTemperature,
    required this.precipitationProbability,
    required this.weatherCode,
    required this.surfacePressure,
    required this.visibility,
    required this.windSpeed10M,
  });

  /// Deserialize the given [json] object into a [HourlyWeatherUnits]
  /// by using the [JsonDecoder] functionality.
  factory HourlyWeatherUnits.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an subtype error.

    var defaultTime = "";
    var defaultTemperature2M = "";
    var defaultRelativeHumidity2M = "";
    var defaultDewPoint2M = "";
    var defaultApparentTemperature = "";
    var defaultPrecipitationProbability = "";
    var defaultWeatherCode = "";
    var defaultSurfacePressure = "";
    var defaultVisibility = "";
    var defaultWindSpeed10M = "";

    if (json['time'] != null &&
        json['temperature_2m'] != null &&
        json['relativehumidity_2m'] != null &&
        json['dewpoint_2m'] != null &&
        json['apparent_temperature'] != null &&
        json['precipitation_probability'] != null &&
        json['weathercode'] != null &&
        json['surface_pressure'] != null &&
        json['visibility'] != null &&
        json['windspeed_10m'] != null) {
      final jsonTime = json['time'] as String;
      defaultTime = jsonTime;

      final jsonTemperature2M = json['temperature_2m'] as String;
      defaultTemperature2M = jsonTemperature2M;

      final jsonRelativeHumidity2M = json['relativehumidity_2m'] as String;
      defaultRelativeHumidity2M = jsonRelativeHumidity2M;

      final jsonDewPoint2M = json['dewpoint_2m'] as String;
      defaultDewPoint2M = jsonDewPoint2M;

      final jsonApparentTemperature = json['apparent_temperature'] as String;
      defaultApparentTemperature = jsonApparentTemperature;

      final jsonPrecipitationProbability =
          json['precipitation_probability'] as String;
      defaultPrecipitationProbability = jsonPrecipitationProbability;

      final jsonWeatherCode = json['weathercode'] as String;
      defaultWeatherCode = jsonWeatherCode;

      final jsonSurfacePressure = json['surface_pressure'] as String;
      defaultSurfacePressure = jsonSurfacePressure;

      final jsonVisibility = json['visibility'] as String;
      defaultVisibility = jsonVisibility;

      final jsonWindSpeed10M = json['windspeed_10m'] as String;
      defaultWindSpeed10M = jsonWindSpeed10M;
    }

    return HourlyWeatherUnits(
      time: defaultTime,
      temperature2M: defaultTemperature2M,
      relativeHumidity2M: defaultRelativeHumidity2M,
      dewPoint2M: defaultDewPoint2M,
      apparentTemperature: defaultApparentTemperature,
      precipitationProbability: defaultPrecipitationProbability,
      weatherCode: defaultWeatherCode,
      surfacePressure: defaultSurfacePressure,
      visibility: defaultVisibility,
      windSpeed10M: defaultWindSpeed10M,
    );
  }

  /// Return the default value of [HourlyWeatherUnits].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  factory HourlyWeatherUnits.defaultValue() {
    return const HourlyWeatherUnits(
      time: "",
      temperature2M: "",
      relativeHumidity2M: "",
      dewPoint2M: "",
      apparentTemperature: "",
      precipitationProbability: "",
      weatherCode: "",
      surfacePressure: "",
      visibility: "",
      windSpeed10M: "",
    );
  }

  /// Convert this [HourlyWeatherUnits] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'time': time,
        'temperature_2m': temperature2M,
        'relativehumidity_2m': relativeHumidity2M,
        'dewpoint_2m': dewPoint2M,
        'apparent_temperature': apparentTemperature,
        'precipitation_probability': precipitationProbability,
        'weathercode': weatherCode,
        'surface_pressure': surfacePressure,
        'visibility': visibility,
        'windspeed_10m': windSpeed10M,
      };

  /// Returns a new object of [HourlyWeatherUnits]
  /// with the same properties as the original,
  /// but with some of the values changed.
  HourlyWeatherUnits copyWith({
    String? time,
    String? temperature2M,
    String? relativeHumidity2M,
    String? dewPoint2M,
    String? apparentTemperature,
    String? precipitationProbability,
    String? weatherCode,
    String? surfacePressure,
    String? visibility,
    String? windSpeed10M,
  }) {
    return HourlyWeatherUnits(
      time: time ?? this.time,
      temperature2M: temperature2M ?? this.temperature2M,
      relativeHumidity2M: relativeHumidity2M ?? this.relativeHumidity2M,
      dewPoint2M: dewPoint2M ?? this.dewPoint2M,
      apparentTemperature: apparentTemperature ?? this.apparentTemperature,
      precipitationProbability:
          precipitationProbability ?? this.precipitationProbability,
      weatherCode: weatherCode ?? this.weatherCode,
      surfacePressure: surfacePressure ?? this.surfacePressure,
      visibility: visibility ?? this.visibility,
      windSpeed10M: windSpeed10M ?? this.windSpeed10M,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        time,
        temperature2M,
        relativeHumidity2M,
        dewPoint2M,
        apparentTemperature,
        precipitationProbability,
        weatherCode,
        surfacePressure,
        visibility,
        windSpeed10M,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
