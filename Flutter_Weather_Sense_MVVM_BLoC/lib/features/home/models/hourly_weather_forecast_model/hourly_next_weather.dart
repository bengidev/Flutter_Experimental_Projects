import 'dart:convert';

import 'package:equatable/equatable.dart';

class HourlyNextWeather extends Equatable {
  final List<String> time;
  final List<double> temperature2M;
  final List<int> relativeHumidity2M;
  final List<double> dewPoint2M;
  final List<double> apparentTemperature;
  final List<int> precipitationProbability;
  final List<int> weatherCode;
  final List<double> surfacePressure;
  final List<double> visibility;
  final List<double> windSpeed10M;

  const HourlyNextWeather({
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

  /// Deserialize the given [json] object into a [HourlyNextWeather]
  /// by using the [JsonDecoder] functionality.
  factory HourlyNextWeather.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an subtype error.

    var defaultTime = <String>[];
    var defaultTemperature2M = <double>[];
    var defaultRelativeHumidity2M = <int>[];
    var defaultDewPoint2M = <double>[];
    var defaultApparentTemperature = <double>[];
    var defaultPrecipitationProbability = <int>[];
    var defaultWeatherCode = <int>[];
    var defaultSurfacePressure = <double>[];
    var defaultVisibility = <double>[];
    var defaultWindSpeed10M = <double>[];

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
      final jsonTime = json['time'] as List<dynamic>;
      defaultTime = List<String>.from(jsonTime.map<String>((e) => e as String));

      final jsonTemperature2M = json['temperature_2m'] as List<dynamic>;
      defaultTemperature2M =
          List<double>.from(jsonTemperature2M.map<double>((e) => e as double));

      final jsonRelativeHumidity2M =
          json['relativehumidity_2m'] as List<dynamic>;
      defaultRelativeHumidity2M =
          List<int>.from(jsonRelativeHumidity2M.map<int>((e) => e as int));

      final jsonDewPoint2M = json['dewpoint_2m'] as List<dynamic>;
      defaultDewPoint2M =
          List<double>.from(jsonDewPoint2M.map<double>((e) => e as double));

      final jsonApparentTemperature =
          json['apparent_temperature'] as List<dynamic>;
      defaultApparentTemperature = List<double>.from(
          jsonApparentTemperature.map<double>((e) => e as double));

      final jsonPrecipitationProbability =
          json['precipitation_probability'] as List<dynamic>;
      defaultPrecipitationProbability = List<int>.from(
          jsonPrecipitationProbability.map<int>((e) => e as int));

      final jsonWeatherCode = json['weathercode'] as List<dynamic>;
      defaultWeatherCode =
          List<int>.from(jsonWeatherCode.map<int>((e) => e as int));

      final jsonSurfacePressure = json['surface_pressure'] as List<dynamic>;
      defaultSurfacePressure = List<double>.from(
          jsonSurfacePressure.map<double>((e) => e as double));

      final jsonVisibility = json['visibility'] as List<dynamic>;
      defaultVisibility =
          List<double>.from(jsonVisibility.map<double>((e) => e as double));

      final jsonWindSpeed10M = json['windspeed_10m'] as List<dynamic>;
      defaultWindSpeed10M =
          List<double>.from(jsonWindSpeed10M.map<double>((e) => e as double));
    }

    return HourlyNextWeather(
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

  /// Convert this [HourlyNextWeather] into a [json] object
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

  /// Returns a new object of [HourlyNextWeather]
  /// with the same properties as the original,
  /// but with some of the values changed.
  HourlyNextWeather copyWith({
    List<String>? time,
    List<double>? temperature2M,
    List<int>? relativeHumidity2M,
    List<double>? dewPoint2M,
    List<double>? apparentTemperature,
    List<int>? precipitationProbability,
    List<int>? weatherCode,
    List<double>? surfacePressure,
    List<double>? visibility,
    List<double>? windSpeed10M,
  }) {
    return HourlyNextWeather(
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

  /// Return the default value of [HourlyNextWeather].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  factory HourlyNextWeather.defaultValue() {
    return const HourlyNextWeather(
      time: <String>[],
      temperature2M: <double>[],
      relativeHumidity2M: <int>[],
      dewPoint2M: <double>[],
      apparentTemperature: <double>[],
      precipitationProbability: <int>[],
      weatherCode: <int>[],
      surfacePressure: <double>[],
      visibility: <double>[],
      windSpeed10M: <double>[],
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
