import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';

/// The base class of the [HourlyWeatherForecastRemoteDataSourceImpl].
///
@immutable
abstract class IHourlyWeatherForecastRemoteDataSource {
  /// Send the [HttpClient]'s GET operation request
  /// to the OpenMateo API.
  ///
  /// This method requires the provided [latitude] and
  /// [longitude] parameters.
  ///
  /// This method will return the [Future] of [HourlyWeatherForecastModel]
  /// when the operation results was succeeded, and
  /// throw the [ServerException] when the operation results
  /// has error which caused by Internet Connection,
  /// or throw the [UnexpectedException]
  /// when the operation results has unknown error.
  Future<HourlyWeatherForecastModel> getHourlyWeatherForecast({
    required double latitude,
    required double longitude,
  });
}
