import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';

@immutable
abstract class IForwardGeocodingRepository {
  Future<Either<Failure, ForwardGeocodingModel>> searchGeocodingLocation({
    required String location,
  });
}
