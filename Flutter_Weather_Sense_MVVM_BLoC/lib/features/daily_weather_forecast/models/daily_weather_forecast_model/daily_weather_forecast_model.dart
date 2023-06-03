import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';

class DailyWeatherForecastModel extends Equatable {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final DailyUnits dailyUnits;
  final DailyWeather dailyWeather;

  const DailyWeatherForecastModel({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.dailyUnits,
    required this.dailyWeather,
  });

  /// Deserialize the given [json] object into a [DailyWeatherForecastModel]
  /// by using the [JsonDecoder] functionality.
  factory DailyWeatherForecastModel.fromJson(Map<String, dynamic> json) {
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
    var defaultDailyUnits = DailyUnits.defaultValue();
    var defaultDailyWeather = DailyWeather.defaultValue();

    if (json['latitude'] != null &&
        json['longitude'] != null &&
        json['generationtime_ms'] != null &&
        json['utc_offset_seconds'] != null &&
        json['timezone'] != null &&
        json['timezone_abbreviation'] != null &&
        json['elevation'] != null &&
        json['daily_units'] != null &&
        json['daily'] != null) {
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

      final jsonDailyUnits = json['daily_units'] as Map<String, dynamic>;
      defaultDailyUnits = DailyUnits.fromJson(jsonDailyUnits);

      final jsonDailyWeather = json['daily'] as Map<String, dynamic>;
      defaultDailyWeather = DailyWeather.fromJson(jsonDailyWeather);
    }

    return DailyWeatherForecastModel(
      latitude: defaultLatitude,
      longitude: defaultLongitude,
      generationTimeMs: defaultGenerationTimeMs,
      utcOffsetSeconds: defaultUtcOffsetSeconds,
      timezone: defaultTimezone,
      timezoneAbbreviation: defaultTimezoneAbbreviation,
      elevation: defaultElevation,
      dailyUnits: defaultDailyUnits,
      dailyWeather: defaultDailyWeather,
    );
  }

  /// Return the default value of [DailyWeatherForecastModel].
  ///
  /// This default value contains an empty [String] or
  /// zero [num], etc for replacing the [Null] value.
  ///
  factory DailyWeatherForecastModel.defaultValue() {
    return DailyWeatherForecastModel(
      latitude: 0.0,
      longitude: 0.0,
      generationTimeMs: 0.0,
      utcOffsetSeconds: 0,
      timezone: "",
      timezoneAbbreviation: "",
      elevation: 0.0,
      dailyUnits: DailyUnits.defaultValue(),
      dailyWeather: DailyWeather.defaultValue(),
    );
  }

  /// Convert this [DailyWeatherForecastModel] into a [json] object
  /// by using the [JsonEncoder] functionality.
  ///
  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationTimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'daily_units': dailyUnits.toJson(),
        'daily': dailyWeather.toJson(),
      };

  /// Returns a new object of [DailyWeatherForecastModel]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ///
  DailyWeatherForecastModel copyWith({
    double? latitude,
    double? longitude,
    double? generationTimeMs,
    int? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    double? elevation,
    DailyUnits? dailyUnits,
    DailyWeather? dailyWeather,
  }) {
    return DailyWeatherForecastModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      generationTimeMs: generationTimeMs ?? this.generationTimeMs,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      timezone: timezone ?? this.timezone,
      timezoneAbbreviation: timezoneAbbreviation ?? this.timezoneAbbreviation,
      elevation: elevation ?? this.elevation,
      dailyUnits: dailyUnits ?? this.dailyUnits,
      dailyWeather: dailyWeather ?? this.dailyWeather,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  ///
  @override
  List<Object?> get props => [
        latitude,
        longitude,
        generationTimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        dailyUnits,
        dailyWeather,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true].
  ///
  @override
  bool? get stringify => true;
}
