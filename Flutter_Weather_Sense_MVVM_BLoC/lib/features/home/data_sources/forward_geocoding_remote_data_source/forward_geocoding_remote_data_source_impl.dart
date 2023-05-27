import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/dependency_injections/dependency_injection.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source/i_forward_geocoding_remote_data_source.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:http/http.dart' as http;

/// The implementation of the [IForwardGeocodingRemoteDataSource]
/// This will require the implementation of all methods from
/// [IForwardGeocodingRemoteDataSource] through the overridden phase.
@immutable
class ForwardGeocodingRemoteDataSourceImpl
    implements IForwardGeocodingRemoteDataSource {
  final http.Client httpClient;

  const ForwardGeocodingRemoteDataSourceImpl({
    required this.httpClient,
  });

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
  @override
  Future<ForwardGeocodingModel> getSearchGeocodingLocation({
    required String location,
  }) {
    final accessToken = $mapBoxAccessToken;
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?'
        'access_token=$accessToken';
    return _getLocationFromURL(url: url);
  }

  /// Simplify the [HttpClient] operation request by separating
  /// the [getSearchGeocodingLocation] method into
  /// the private method [_getLocationFromURL].
  ///
  /// This method requires the same parameters from
  /// the [getSearchGeocodingLocation] method.
  Future<ForwardGeocodingModel> _getLocationFromURL({
    required String url,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final response = await httpClient.get(parsedUrl, headers: headers);

    if (response.statusCode == 200) {
      try {
        return ForwardGeocodingModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } catch (e) {
        rethrow;
      }
    } else if (response.statusCode >= 401 && response.statusCode <= 429) {
      throw ServerException(
        message: "code: ${response.statusCode}, "
            "description: ${response.reasonPhrase}",
      );
    } else {
      throw const UnexpectedException();
    }
  }
}
