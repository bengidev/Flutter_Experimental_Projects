import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';

/// The base class of the [DailyWeatherForecastRepositoryImpl].
///
@immutable
abstract class IDailyWeatherForecastRepository {
  /// Find the weather forecast based on the given [latitude]
  /// and [longitude] coordinates value.
  ///
  /// This method using the daily weather type to forecast
  /// next seven days predicted weather.
  ///
  /// This method will return the [Future] of [Failure]
  /// when something error was happened,
  /// and return the [Future] of [DailyWeatherForecastModel]
  /// when the operation results was successful.
  ///
  Future<Either<Failure, DailyWeatherForecastModel>> findDailyWeatherForecast({
    required double latitude,
    required double longitude,
  });
}
