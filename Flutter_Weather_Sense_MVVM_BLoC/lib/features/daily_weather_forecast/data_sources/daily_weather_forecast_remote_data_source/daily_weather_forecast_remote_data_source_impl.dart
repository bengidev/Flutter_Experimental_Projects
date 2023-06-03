import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/errors/exceptions.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:http/http.dart' as http;

/// The implementation of the [IDailyWeatherForecastRemoteDataSource].
///
/// This will require the implementation of all methods from
/// [IDailyWeatherForecastRemoteDataSource] through the overridden phase.
///
@immutable
class DailyWeatherForecastRemoteDataSourceImpl
    implements IDailyWeatherForecastRemoteDataSource {
  final http.Client httpClient;

  const DailyWeatherForecastRemoteDataSourceImpl({
    required this.httpClient,
  });

  /// Send the [HttpClient]'s GET operation request
  /// to the OpenMateo API.
  ///
  /// This method requires the provided [latitude] and
  /// [longitude] parameters.
  ///
  /// This method will return the [Future] of [DailyWeatherForecastModel]
  /// when the operation results was succeeded, and
  /// throw the [ServerException] when the operation results
  /// has error which caused by Internet Connection,
  /// or throw the [UnexpectedException]
  /// when the operation results has unknown error.
  ///
  @override
  Future<DailyWeatherForecastModel> getDailyWeatherForecast({
    required double latitude,
    required double longitude,
  }) {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&'
        'daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,'
        'precipitation_probability_max,windspeed_10m_max&timezone=auto';

    return _getWeatherForecastFromURL(url: url);
  }

  /// Simplify the [HttpClient] operation request by separating
  /// the [getDailyWeatherForecast] method into
  /// the private method [_getWeatherForecastFromURL].
  ///
  /// This method requires the same parameters from
  /// the [getDailyWeatherForecast] method.
  Future<DailyWeatherForecastModel> _getWeatherForecastFromURL({
    required String url,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final response = await httpClient.get(parsedUrl, headers: headers);

    if (response.statusCode == 200) {
      try {
        return DailyWeatherForecastModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } catch (e) {
        rethrow;
      }
    } else if (response.statusCode >= 400) {
      throw ServerException(
        message: "code: ${response.statusCode}, "
            "description: ${response.reasonPhrase}",
      );
    } else {
      throw const UnexpectedException();
    }
  }
}
