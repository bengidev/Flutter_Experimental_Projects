import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/hourly_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_weather_forecast_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/hourly_weather_forecast_repository/i_hourly_weather_forecast_repository.dart';

/// The implementation of the [IHourlyWeatherForecastRepository].
/// This will require the implementation of all methods from
/// [IHourlyWeatherForecastRepository] through the overridden phase.
///
@immutable
class HourlyWeatherForecastRepositoryImpl
    implements IHourlyWeatherForecastRepository {
  final IHourlyWeatherForecastRemoteDataSource remoteDataSource;

  const HourlyWeatherForecastRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Find the weather forecast based on the given [latitude]
  /// and [longitude] coordinates value. This method using
  /// the hourly weather type to forecast next incoming
  /// predicted weather.
  ///
  /// This method will return the [Future] of [Failure]
  /// when something error was happened,
  /// and return the [Future] of [HourlyWeatherForecastModel]
  /// when the operation results was successful.
  ///
  @override
  Future<Either<Failure, HourlyWeatherForecastModel>>
      findHourlyWeatherForecast({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final forecastWeatherResults =
          await remoteDataSource.getHourlyWeatherForecast(
        latitude: latitude,
        longitude: longitude,
      );
      return Right(forecastWeatherResults);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
