import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository/i_forward_geocoding_repository.dart';

/// The implementation of the [IForwardGeocodingRepository].
/// This will require the implementation of all methods from
/// [IForwardGeocodingRepository] through the overridden phase.
@immutable
class ForwardGeocodingRepositoryImpl implements IForwardGeocodingRepository {
  final IForwardGeocodingRemoteDataSource remoteDataSource;

  const ForwardGeocodingRepositoryImpl({
    required this.remoteDataSource,
  });

  /// Search the geocoding location based on the given [location].
  /// This method will return the [Future] of [Failure]
  /// when something error was happened, and return [ForwardGeocodingModel]
  /// when the operation results was successful.
  @override
  Future<Either<Failure, ForwardGeocodingModel>> searchGeocodingLocation({
    required String location,
  }) async {
    try {
      final locationResults = await remoteDataSource.getSearchGeocodingLocation(
        location: location,
      );
      return Right(locationResults);
    } on ServerException catch (serverException) {
      return Left(ServerFailure(message: serverException.message));
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
