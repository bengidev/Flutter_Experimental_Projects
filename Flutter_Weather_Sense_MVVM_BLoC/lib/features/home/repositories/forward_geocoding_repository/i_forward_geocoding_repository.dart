import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository/forward_geocoding_repository_impl.dart';

/// The base class of the [ForwardGeocodingRepositoryImpl].
@immutable
abstract class IForwardGeocodingRepository {
  /// Search the geocoding location based on the given [location].
  /// This method will return the [Future] of [Failure]
  /// when something error was happened,
  /// and return the [Future] of [ForwardGeocodingModel]
  /// when the operation results was successful.
  Future<Either<Failure, ForwardGeocodingModel>> searchGeocodingLocation({
    required String location,
  });
}
