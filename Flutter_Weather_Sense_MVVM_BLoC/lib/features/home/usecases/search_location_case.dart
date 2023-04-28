import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/failures.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/use_cases/use_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repositories_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_input_parameter.dart';

@immutable
class SearchLocationCase
    implements
        IUseCase<SearchInputParameter,
            Future<Either<Failure, ForwardGeocodingModel>>> {
  final IForwardGeocodingRepository forwardGeocodingRepository;

  const SearchLocationCase({
    required this.forwardGeocodingRepository,
  });

  @override
  Future<Either<Failure, ForwardGeocodingModel>> call(
    SearchInputParameter parameters,
  ) {
    return forwardGeocodingRepository.searchGeocodingLocation(
      location: parameters.location,
    );
  }
}