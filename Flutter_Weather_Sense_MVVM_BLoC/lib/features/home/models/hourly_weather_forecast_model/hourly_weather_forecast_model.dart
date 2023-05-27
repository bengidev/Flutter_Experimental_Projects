import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_current_weather.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_next_weather.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_weather_units.dart';

class HourlyWeatherForecastModel extends Equatable {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final HourlyCurrentWeather hourlyCurrentWeather;
  final HourlyWeatherUnits hourlyWeatherUnits;
  final HourlyNextWeather hourlyNextWeather;

  const HourlyWeatherForecastModel({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.hourlyCurrentWeather,
    required this.hourlyWeatherUnits,
    required this.hourlyNextWeather,
  });

  /// Deserialize the given [json] object into a [HourlyWeatherForecastModel]
  /// by using the [JsonDecoder] functionality.
  factory HourlyWeatherForecastModel.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an subtype error.

    var defaultLatitude = 0.0;
    var defaultLongitude = 0.0;
    var defaultGenerationTimeMs = 0.0;
    var defaultUtcOffsetSeconds = 0;
    var defaultTimezone = "";
    var defaultTimezoneAbbreviation = "";
    var defaultElevation = 0.0;
    var defaultHourlyCurrentWeather = const HourlyCurrentWeather(
      temperature: 0,
      windSpeed: 0,
      windDirection: 0,
      weatherCode: 0,
      isDay: 0,
      time: '',
    );
    var defaultHourlyWeatherUnits = const HourlyWeatherUnits(
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
    var defaultHourlyNextWeather = const HourlyNextWeather(
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

    if (json['latitude'] != null &&
        json['longitude'] != null &&
        json['generationtime_ms'] != null &&
        json['utc_offset_seconds'] != null &&
        json['timezone'] != null &&
        json['timezone_abbreviation'] != null &&
        json['elevation'] != null &&
        json['current_weather'] != null &&
        json['hourly_units'] != null &&
        json['hourly'] != null) {
      final jsonLatitude = json['latitude'] as double;
      defaultLatitude = jsonLatitude;

      final jsonLongitude = json['longitude'] as double;
      defaultLongitude = jsonLongitude;

      final jsonGenerationTimeMs = json['generationtime_ms'] as double;
      defaultGenerationTimeMs = jsonGenerationTimeMs;

      final jsonUtcOffsetSeconds = json['utc_offset_seconds'] as int;
      defaultUtcOffsetSeconds = jsonUtcOffsetSeconds;

      final jsonTimezone = json['timezone'] as String;
      defaultTimezone = jsonTimezone;

      final jsonTimezoneAbbreviation = json['timezone_abbreviation'] as String;
      defaultTimezoneAbbreviation = jsonTimezoneAbbreviation;

      final jsonElevation = json['elevation'] as double;
      defaultElevation = jsonElevation;

      final jsonHourlyCurrentWeather =
          json['current_weather'] as Map<String, dynamic>;
      defaultHourlyCurrentWeather =
          HourlyCurrentWeather.fromJson(jsonHourlyCurrentWeather);

      final jsonHourlyWeatherUnits =
          json['hourly_units'] as Map<String, dynamic>;
      defaultHourlyWeatherUnits =
          HourlyWeatherUnits.fromJson(jsonHourlyWeatherUnits);

      final jsonHourlyNextWeather = json['hourly'] as Map<String, dynamic>;
      defaultHourlyNextWeather =
          HourlyNextWeather.fromJson(jsonHourlyNextWeather);
    }

    return HourlyWeatherForecastModel(
      latitude: defaultLatitude,
      longitude: defaultLongitude,
      generationTimeMs: defaultGenerationTimeMs,
      utcOffsetSeconds: defaultUtcOffsetSeconds,
      timezone: defaultTimezone,
      timezoneAbbreviation: defaultTimezoneAbbreviation,
      elevation: defaultElevation,
      hourlyCurrentWeather: defaultHourlyCurrentWeather,
      hourlyWeatherUnits: defaultHourlyWeatherUnits,
      hourlyNextWeather: defaultHourlyNextWeather,
    );
  }

  /// Return the default value of [HourlyWeatherForecastModel].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  factory HourlyWeatherForecastModel.defaultValue() {
    return const HourlyWeatherForecastModel(
      latitude: 0,
      longitude: 0,
      elevation: 0,
      generationTimeMs: 0,
      timezone: "",
      timezoneAbbreviation: "",
      utcOffsetSeconds: 0,
      hourlyCurrentWeather: HourlyCurrentWeather(
        temperature: 0,
        windSpeed: 0,
        windDirection: 0,
        weatherCode: 0,
        isDay: 0,
        time: "",
      ),
      hourlyWeatherUnits: HourlyWeatherUnits(
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
      ),
      hourlyNextWeather: HourlyNextWeather(
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
      ),
    );
  }

  /// Convert this [HourlyWeatherForecastModel] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationTimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current_weather': hourlyCurrentWeather.toJson(),
        'hourly_units': hourlyWeatherUnits.toJson(),
        'hourly': hourlyNextWeather.toJson(),
      };

  /// Returns a new object of [HourlyWeatherForecastModel]
  /// with the same properties as the original,
  /// but with some of the values changed.
  HourlyWeatherForecastModel copyWith({
    double? latitude,
    double? longitude,
    double? generationTimeMs,
    int? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    double? elevation,
    HourlyCurrentWeather? hourlyCurrentWeather,
    HourlyNextWeather? hourlyNextWeather,
    HourlyWeatherUnits? hourlyWeatherUnits,
  }) {
    return HourlyWeatherForecastModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      generationTimeMs: generationTimeMs ?? this.generationTimeMs,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      timezone: timezone ?? this.timezone,
      timezoneAbbreviation: timezoneAbbreviation ?? this.timezoneAbbreviation,
      elevation: elevation ?? this.elevation,
      hourlyCurrentWeather: hourlyCurrentWeather ?? this.hourlyCurrentWeather,
      hourlyWeatherUnits: hourlyWeatherUnits ?? this.hourlyWeatherUnits,
      hourlyNextWeather: hourlyNextWeather ?? this.hourlyNextWeather,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        latitude,
        longitude,
        generationTimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        hourlyCurrentWeather,
        hourlyWeatherUnits,
        hourlyNextWeather,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
