import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/i_forward_geocoding_remote_data_source.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';
import 'package:http/http.dart' as http;

@immutable
class ForwardGeocodingRemoteDataSourceImpl
    implements IForwardGeocodingRemoteDataSource {
  final http.Client httpClient;

  const ForwardGeocodingRemoteDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<ForwardGeocodingModel> getSearchGeocodingLocation({
    required String location,
  }) {
    const accessToken =
        'pk.eyJ1Ijoic3luZGljYXRlMDE3IiwiYSI6ImNsZ2FmYjdodTA4NnMzcnByYjhneHFyd2oifQ.'
        'GhpidZgojTsBEGluIkWvTw';
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$location.json?'
        'access_token=$accessToken';
    return _getLocationFromURL(url: url);
  }

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
    } else {
      throw const ServerException();
    }
  }
}
