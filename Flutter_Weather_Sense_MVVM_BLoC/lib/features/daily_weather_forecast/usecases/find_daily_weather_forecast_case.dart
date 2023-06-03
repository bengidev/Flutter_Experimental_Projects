import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/use_cases/use_cases_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';

/// The implementation of [IUseCase] with overriding
/// the generics type of the abstract [IUseCase] itself.
///
/// Then it will generate the input and output based on
/// its generics type, which will applied into the
/// [call] callable class' method.
///
class FindDailyWeatherForecastCase
    implements
        IUseCase<DailyWeatherForecastParameter,
            Future<Either<Failure, DailyWeatherForecastModel>>> {
  final IDailyWeatherForecastRepository dailyWeatherForecastRepository;

  const FindDailyWeatherForecastCase({
    required this.dailyWeatherForecastRepository,
  });

  @override
  Future<Either<Failure, DailyWeatherForecastModel>> call(
    DailyWeatherForecastParameter parameters,
  ) {
    return dailyWeatherForecastRepository.findDailyWeatherForecast(
      latitude: parameters.latitude,
      longitude: parameters.longitude,
    );
  }
}

/// The parameter object of the use case's implementation.
///
/// This will give you the easy access of all the
/// required object with just a single use case's parameter.
///
class DailyWeatherForecastParameter extends Equatable {
  final double latitude;
  final double longitude;

  const DailyWeatherForecastParameter({
    required this.latitude,
    required this.longitude,
  });

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool get stringify => true;
}
