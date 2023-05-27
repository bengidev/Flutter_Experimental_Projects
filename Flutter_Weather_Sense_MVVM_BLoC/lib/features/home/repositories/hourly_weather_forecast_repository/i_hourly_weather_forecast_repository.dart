import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/hourly_weather_forecast_repository/hourly_weather_forecast_repository_impl.dart';

/// The base class of the [HourlyWeatherForecastRepositoryImpl].
@immutable
abstract class IHourlyWeatherForecastRepository {
  /// Find the weather forecast based on the given [latitude]
  /// and [longitude] coordinates value. This method using
  /// the hourly weather type to forecast next incoming
  /// predicted weather.
  ///
  /// This method will return the [Future] of [Failure]
  /// when something error was happened,
  /// and return the [Future] of [HourlyWeatherForecastModel]
  /// when the operation results was successful.
  Future<Either<Failure, HourlyWeatherForecastModel>>
      findHourlyWeatherForecast({
    required double latitude,
    required double longitude,
  });
}
