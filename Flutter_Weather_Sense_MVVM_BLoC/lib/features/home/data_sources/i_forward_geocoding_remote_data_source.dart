import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';

@immutable
abstract class IForwardGeocodingRemoteDataSource {
  Future<ForwardGeocodingModel> getSearchGeocodingLocation(
      {required String location});
}
