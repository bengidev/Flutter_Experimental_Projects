import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

/// The base class of the [ForwardGeocodingRemoteDataSourceImpl].
@immutable
abstract class IForwardGeocodingRemoteDataSource {
  Future<ForwardGeocodingModel> getSearchGeocodingLocation(
      {required String location});
}
