import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/failures.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/use_cases/i_use_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repositories_barrel.dart';

/// The implementation of [IUseCase] with overriding
/// the generics type of the abstract [IUseCase] itself.
///
/// Then it will generate the input and output based on
/// its generics type, which will applied into the
/// [call] callable class' method.
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

/// The parameter object of the use case's implementation.
/// This will give you the easy access of all the
/// required object with just a single use case's parameter.
class SearchInputParameter extends Equatable {
  final String location;

  const SearchInputParameter({
    required this.location,
  });

  @override
  List<Object?> get props => [location];

  @override
  bool get stringify => true;
}
