import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

/// The base class of the [ForwardGeocodingRemoteDataSourceImpl].
@immutable
abstract class IForwardGeocodingRemoteDataSource {
  /// Send the [HttpClient]'s GET operation request
  /// to the MapBox API.
  ///
  /// This method requires the provided [location].
  ///
  /// It will return the [Future] of [ForwardGeocodingModel]
  /// when the operation results was succeeded, and it will
  /// throw the [ServerException] when the operation results
  /// has error which caused by Internet Connection,
  /// or it will throw the [UnexpectedException]
  /// when the operation results has unknown error.
  Future<ForwardGeocodingModel> getSearchGeocodingLocation({
    required String location,
  });
}
