import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/exceptions.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/hourly_weather_forecast_remote_data_source/i_hourly_weather_forecast_remote_data_source.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_weather_forecast_model.dart';
import 'package:http/http.dart' as http;

/// The implementation of the [IHourlyWeatherForecastRemoteDataSource]
/// This will require the implementation of all methods from
/// [IHourlyWeatherForecastRemoteDataSource] through the overridden phase.
///
@immutable
class HourlyWeatherForecastRemoteDataSourceImpl
    implements IHourlyWeatherForecastRemoteDataSource {
  final http.Client httpClient;

  const HourlyWeatherForecastRemoteDataSourceImpl({
    required this.httpClient,
  });

  /// Send the [HttpClient]'s GET operation request
  /// to the OpenMateo API.
  ///
  /// This method requires the provided [latitude] and
  /// [longitude] parameters.
  ///
  /// This method will return the [Future] of [HourlyWeatherForecastModel]
  /// when the operation results was succeeded, and
  /// throw the [ServerException] when the operation results
  /// has error which caused by Internet Connection,
  /// or throw the [UnexpectedException]
  /// when the operation results has unknown error.
  @override
  Future<HourlyWeatherForecastModel> getHourlyWeatherForecast({
    required double latitude,
    required double longitude,
  }) {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&'
        'hourly=temperature_2m,relativehumidity_2m,dewpoint_2m,apparent_temperature'
        ',precipitation_probability,weathercode,surface_pressure,visibility,'
        'windspeed_10m&current_weather=true&timezone=auto';

    return _getWeatherForecastFromURL(url: url);
  }

  /// Simplify the [HttpClient] operation request by separating
  /// the [getHourlyWeatherForecast] method into
  /// the private method [_getWeatherForecastFromURL].
  ///
  /// This method requires the same parameters from
  /// the [getHourlyWeatherForecast] method.
  Future<HourlyWeatherForecastModel> _getWeatherForecastFromURL({
    required String url,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final response = await httpClient.get(parsedUrl, headers: headers);

    if (response.statusCode == 200) {
      try {
        return HourlyWeatherForecastModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } catch (e) {
        rethrow;
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
        message: "code: ${response.statusCode}, "
            "description: ${response.reasonPhrase}",
      );
    } else {
      throw const UnexpectedException();
    }
  }
}
