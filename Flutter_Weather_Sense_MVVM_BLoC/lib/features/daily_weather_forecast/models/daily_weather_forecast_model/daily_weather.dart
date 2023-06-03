import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyWeather extends Equatable {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperature2MMax;
  final List<double> temperature2MMin;
  final List<String> sunrise;
  final List<String> sunset;
  final List<int> precipitationProbabilityMax;
  final List<double> windSpeed10MMax;

  const DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.temperature2MMax,
    required this.temperature2MMin,
    required this.sunrise,
    required this.sunset,
    required this.precipitationProbabilityMax,
    required this.windSpeed10MMax,
  });

  /// Deserialize the given [json] object into a [DailyWeather]
  /// by using the [JsonDecoder] functionality.
  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
// so it cannot be explicitly typecast-ed to the subtype that you want.
// You must safely typecast the value before you used it,
// or it will show an subtype error.

    var defaultTime = <String>[];
    var defaultWeatherCode = <int>[];
    var defaultTemperature2MMax = <double>[];
    var defaultTemperature2MMin = <double>[];
    var defaultSunrise = <String>[];
    var defaultSunset = <String>[];
    var defaultPrecipitationProbabilityMax = <int>[];
    var defaultWindSpeed10MMax = <double>[];

    if (json['time'] != null &&
        json['weathercode'] != null &&
        json['temperature_2m_max'] != null &&
        json['temperature_2m_min'] != null &&
        json['sunrise'] != null &&
        json['sunset'] != null &&
        json['precipitation_probability_max'] != null &&
        json['windspeed_10m_max'] != null) {
      final jsonTime = json['time'] as List<dynamic>;
      final mappedJsonTime =
          List<String>.from(jsonTime.map<String>((e) => e as String));
      defaultTime = mappedJsonTime;

      final jsonWeatherCode = json['weathercode'] as List<dynamic>;
      final mappedJsonWeatherCode =
          List<int>.from(jsonWeatherCode.map<int>((e) => e as int));
      defaultWeatherCode = mappedJsonWeatherCode;

      final jsonTemperature2MMax = json['temperature_2m_max'] as List<dynamic>;
      final mappedJsonTemperature2MMax = List<double>.from(
          jsonTemperature2MMax.map<double>((e) => e as double));
      defaultTemperature2MMax = mappedJsonTemperature2MMax;

      final jsonTemperature2MMin = json['temperature_2m_min'] as List<dynamic>;
      final mappedJsonTemperature2MMin = List<double>.from(
          jsonTemperature2MMin.map<double>((e) => e as double));
      defaultTemperature2MMin = mappedJsonTemperature2MMin;

      final jsonSunrise = json['sunrise'] as List<dynamic>;
      final mappedJsonSunrise =
          List<String>.from(jsonSunrise.map<String>((e) => e as String));
      defaultSunrise = mappedJsonSunrise;

      final jsonSunset = json['sunset'] as List<dynamic>;
      final mappedJsonSunset =
          List<String>.from(jsonSunset.map<String>((e) => e as String));
      defaultSunset = mappedJsonSunset;

      final jsonPrecipitationProbabilityMax =
          json['precipitation_probability_max'] as List<dynamic>;
      final mappedJsonPrecipitationProbabilityMax = List<int>.from(
          jsonPrecipitationProbabilityMax.map<int>((e) => e as int));
      defaultPrecipitationProbabilityMax =
          mappedJsonPrecipitationProbabilityMax;

      final jsonWindSpeed10MMax = json['windspeed_10m_max'] as List<dynamic>;
      final mappedJsonWindSpeed10MMax = List<double>.from(
          jsonWindSpeed10MMax.map<double>((e) => e as double));
      defaultWindSpeed10MMax = mappedJsonWindSpeed10MMax;
    }

    return DailyWeather(
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

  /// Return the default value of [DailyWeather].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  ///
  factory DailyWeather.defaultValue() {
    return const DailyWeather(
      time: <String>[],
      weatherCode: <int>[],
      temperature2MMax: <double>[],
      temperature2MMin: <double>[],
      sunrise: <String>[],
      sunset: <String>[],
      precipitationProbabilityMax: <int>[],
      windSpeed10MMax: <double>[],
    );
  }

  /// Convert this [DailyWeather] into a [json] object
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

  /// Returns a new object of [DailyWeather]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ///
  DailyWeather copyWith({
    List<String>? time,
    List<int>? weatherCode,
    List<double>? temperature2MMax,
    List<double>? temperature2MMin,
    List<String>? sunrise,
    List<String>? sunset,
    List<int>? precipitationProbabilityMax,
    List<double>? windSpeed10MMax,
  }) {
    return DailyWeather(
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
  /// by changing the [stringify] value into [true]
  ///
  @override
  bool? get stringify => true;
}
