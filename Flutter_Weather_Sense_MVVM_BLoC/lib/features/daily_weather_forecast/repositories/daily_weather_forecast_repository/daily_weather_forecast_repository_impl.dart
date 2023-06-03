import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model/daily_weather_forecast_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';

/// The implementation of the [IDailyWeatherForecastRepository].
///
/// This will require the implementation of all methods from
/// [IDailyWeatherForecastRepository] through the overridden phase.
///
@immutable
class DailyWeatherForecastRepositoryImpl
    implements IDailyWeatherForecastRepository {
  final IDailyWeatherForecastRemoteDataSource remoteDataSource;

  const DailyWeatherForecastRepositoryImpl({
    required this.remoteDataSource,
  });

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
  @override
  Future<Either<Failure, DailyWeatherForecastModel>> findDailyWeatherForecast({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final forecastWeatherResults =
          await remoteDataSource.getDailyWeatherForecast(
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
