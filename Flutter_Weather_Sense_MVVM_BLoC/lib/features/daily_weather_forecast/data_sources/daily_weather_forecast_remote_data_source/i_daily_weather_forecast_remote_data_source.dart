import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/exceptions.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';

/// The base class of the [DailyWeatherForecastRemoteDataSourceImpl].
///
@immutable
abstract class IDailyWeatherForecastRemoteDataSource {
  /// Send the [HttpClient]'s GET operation request
  /// to the OpenMateo API.
  ///
  /// This method requires the provided [latitude] and
  /// [longitude] parameters.
  ///
  /// This method will return the [Future] of [DailyWeatherForecastModel]
  /// when the operation results was succeeded, and
  /// throw the [ServerException] when the operation results
  /// has error which caused by Internet Connection,
  /// or throw the [UnexpectedException]
  /// when the operation results has unknown error.
  ///
  Future<DailyWeatherForecastModel> getDailyWeatherForecast({
    required double latitude,
    required double longitude,
  });
}
