import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static const _onboardingCompletedKey = "ONBOARDING_COMPLETED_KEY";
  static const _latestModelForwardFeatureKey =
      "LATEST_FORWARD_GEOCODING_MODEL_KEY";
  static const _latestHourlyWeatherForecastModelKey =
      "LATEST_HOURLY_WEATHER_FORECAST_MODEL_KEY";
  static const _latestHourlyCurrentWeatherKey =
      "LATEST_HOURLY_CURRENT_WEATHER_KEY";
  static const _latestLatitudeCoordinateKey = "LATEST_LATITUDE_COORDINATE_KEY";
  static const _latestLongitudeCoordinateKey =
      "LATEST_LONGITUDE_COORDINATE_KEY";

  /// Test the static [setHasOnboardingCompleted] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setHasOnboardingCompleted].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<bool> testSetWasOnboardingCompleted({
    required bool wasCompleted,
  }) {
    return SharedPreferencesStorage.setHasOnboardingCompleted(
      wasCompleted: wasCompleted,
    );
  }

  /// Store the value of [bool] into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static Future<bool> setHasOnboardingCompleted({
    required bool wasCompleted,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final onboardingResults = sharedPreferences.setBool(
      SharedPreferencesStorage._onboardingCompletedKey,
      wasCompleted,
    );
    return onboardingResults;
  }

  /// Test the static [getHasOnboardingCompleted] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getHasOnboardingCompleted].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  bool testGetWasOnboardingCompleted() {
    return SharedPreferencesStorage.getHasOnboardingCompleted();
  }

  /// Retrieve the value of [bool] from [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static bool getHasOnboardingCompleted() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final onboardingResults = sharedPreferences.getBool(
      SharedPreferencesStorage._onboardingCompletedKey,
    );

    if (onboardingResults != null) {
      return onboardingResults;
    } else {
      return false;
    }
  }

  /// Test the static [setLatestModelForwardFeature] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setLatestModelForwardFeature].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<bool> testSetLatestModelForwardFeature({
    required ForwardFeature modelFeature,
  }) {
    return SharedPreferencesStorage.setLatestModelForwardFeature(
      modelFeature: modelFeature,
    );
  }

  /// Store the encoded [String] value of [ForwardFeature]
  /// into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static Future<bool> setLatestModelForwardFeature({
    required ForwardFeature modelFeature,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final encodedModelForwardFeature = json.encode(modelFeature.toJson());
    final modelResults = sharedPreferences.setString(
      SharedPreferencesStorage._latestModelForwardFeatureKey,
      encodedModelForwardFeature,
    );

    return modelResults;
  }

  /// Test the static [getLatestModelForwardFeature] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getLatestModelForwardFeature].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  ForwardFeature? testGetLatestModelForwardFeature() {
    return SharedPreferencesStorage.getLatestModelForwardFeature();
  }

  /// Retrieve the latest value of [ForwardFeature] from
  /// [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static ForwardFeature? getLatestModelForwardFeature() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final modelForwardFeatureResults = sharedPreferences
        .getString(SharedPreferencesStorage._latestModelForwardFeatureKey);

    if (modelForwardFeatureResults != null &&
        modelForwardFeatureResults.isNotEmpty) {
      final decodedModelForwardFeature = ForwardFeature.fromJson(
        json.decode(modelForwardFeatureResults) as Map<String, dynamic>,
      );
      return decodedModelForwardFeature;
    } else {
      return null;
    }
  }

  /// Test the static [setLatestHourlyWeatherForecastModel] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setLatestHourlyWeatherForecastModel].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<bool> testSetLatestHourlyWeatherForecastModel({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
  }) {
    return SharedPreferencesStorage.setLatestHourlyWeatherForecastModel(
      hourlyWeatherForecastModel: hourlyWeatherForecastModel,
    );
  }

  /// Store the encoded [String] value of [HourlyWeatherForecastModel]
  /// into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static Future<bool> setLatestHourlyWeatherForecastModel({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final encodedHourlyWeatherForecastModel =
        json.encode(hourlyWeatherForecastModel.toJson());
    final modelResults = sharedPreferences.setString(
      SharedPreferencesStorage._latestHourlyWeatherForecastModelKey,
      encodedHourlyWeatherForecastModel,
    );

    debugPrint(
      "encodedHourlyWeatherForecastModel -> $encodedHourlyWeatherForecastModel",
    );

    return modelResults;
  }

  /// Test the static [getLatestHourlyWeatherForecastModel] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getLatestHourlyWeatherForecastModel].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  HourlyWeatherForecastModel? testGetLatestHourlyWeatherForecastModel() {
    return SharedPreferencesStorage.getLatestHourlyWeatherForecastModel();
  }

  /// Retrieve the latest value of [HourlyWeatherForecastModel] from
  /// [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static HourlyWeatherForecastModel? getLatestHourlyWeatherForecastModel() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final hourlyWeatherForecastModelResults = sharedPreferences.getString(
      SharedPreferencesStorage._latestHourlyWeatherForecastModelKey,
    );

    if (hourlyWeatherForecastModelResults != null &&
        hourlyWeatherForecastModelResults.isNotEmpty) {
      debugPrint(
        "hourlyWeatherForecastModelResults -> $hourlyWeatherForecastModelResults",
      );

      final decodedHourlyWeatherForecastModel =
          HourlyWeatherForecastModel.fromJson(
        json.decode(hourlyWeatherForecastModelResults) as Map<String, dynamic>,
      );

      debugPrint(
        "decodedHourlyWeatherForecastModel -> $decodedHourlyWeatherForecastModel",
      );
      return decodedHourlyWeatherForecastModel;
    } else {
      return null;
    }
  }

  /// Test the static [setLatestHourlyCurrentWeather] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setLatestHourlyCurrentWeather].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  Future<bool> testSetLatestHourlyCurrentWeather({
    required HourlyCurrentWeather hourlyCurrentWeather,
  }) {
    return SharedPreferencesStorage.setLatestHourlyCurrentWeather(
      hourlyCurrentWeather: hourlyCurrentWeather,
    );
  }

  /// Store the encoded [String] value of [HourlyCurrentWeather]
  /// into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static Future<bool> setLatestHourlyCurrentWeather({
    required HourlyCurrentWeather hourlyCurrentWeather,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final encodedHourlyCurrentWeather =
        json.encode(hourlyCurrentWeather.toJson());
    final modelResults = sharedPreferences.setString(
      SharedPreferencesStorage._latestHourlyCurrentWeatherKey,
      encodedHourlyCurrentWeather,
    );

    debugPrint(
      "encodedHourlyCurrentWeather -> $encodedHourlyCurrentWeather",
    );

    return modelResults;
  }

  /// Test the static [getLatestHourlyCurrentWeather] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getLatestHourlyCurrentWeather].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  HourlyCurrentWeather? testGetLatestHourlyCurrentWeather() {
    return SharedPreferencesStorage.getLatestHourlyCurrentWeather();
  }

  /// Retrieve the latest value of [HourlyCurrentWeather] from
  /// [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static HourlyCurrentWeather? getLatestHourlyCurrentWeather() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final hourlyCurrentWeatherResults = sharedPreferences.getString(
      SharedPreferencesStorage._latestHourlyCurrentWeatherKey,
    );

    if (hourlyCurrentWeatherResults != null &&
        hourlyCurrentWeatherResults.isNotEmpty) {
      debugPrint(
        "hourlyCurrentWeatherResults -> $hourlyCurrentWeatherResults",
      );

      final decodedHourlyCurrentWeather = HourlyCurrentWeather.fromJson(
        json.decode(hourlyCurrentWeatherResults) as Map<String, dynamic>,
      );

      debugPrint(
        "decodedHourlyCurrentWeather -> $decodedHourlyCurrentWeather",
      );
      return decodedHourlyCurrentWeather;
    } else {
      return null;
    }
  }

  /// Test the static [setLatestLatitudeCoordinate] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setLatestLatitudeCoordinate].
  ///
  /// This method only available for testing purpose only.
  ///
  @visibleForTesting
  Future<bool> testSetLatestLatitudeCoordinate({
    required double latitude,
  }) {
    return SharedPreferencesStorage.setLatestLatitudeCoordinate(
      latitude: latitude,
    );
  }

  /// Store the value of [double] into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  ///
  static Future<bool> setLatestLatitudeCoordinate({
    required double latitude,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final latestLatitudeResults = sharedPreferences.setDouble(
      SharedPreferencesStorage._latestLatitudeCoordinateKey,
      latitude,
    );
    return latestLatitudeResults;
  }

  /// Test the static [getLatestLatitudeCoordinate] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getLatestLatitudeCoordinate].
  ///
  /// This method only available for testing purpose only.
  ///
  @visibleForTesting
  double testGetLatestLatitudeCoordinate() {
    return SharedPreferencesStorage.getLatestLatitudeCoordinate();
  }

  /// Retrieve the value of [double] from [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  ///
  static double getLatestLatitudeCoordinate() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final latestLatitudeResults = sharedPreferences.getDouble(
      SharedPreferencesStorage._latestLatitudeCoordinateKey,
    );

    if (latestLatitudeResults != null) {
      return latestLatitudeResults;
    } else {
      return 0.0;
    }
  }

  /// Test the static [setLatestLongitudeCoordinate] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [setLatestLongitudeCoordinate].
  ///
  /// This method only available for testing purpose only.
  ///
  @visibleForTesting
  Future<bool> testSetLatestLongitudeCoordinate({
    required double latitude,
  }) {
    return SharedPreferencesStorage.setLatestLongitudeCoordinate(
      longitude: latitude,
    );
  }

  /// Store the value of [double] into [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  ///
  static Future<bool> setLatestLongitudeCoordinate({
    required double longitude,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final latestLongitudeResults = sharedPreferences.setDouble(
      SharedPreferencesStorage._latestLongitudeCoordinateKey,
      longitude,
    );
    return latestLongitudeResults;
  }

  /// Test the static [getLatestLongitudeCoordinate] method
  /// of the [SharedPreferencesStorage]'s class.
  ///
  /// It will return the results from [getLatestLongitudeCoordinate].
  ///
  /// This method only available for testing purpose only.
  ///
  @visibleForTesting
  double testGetLatestLongitudeCoordinate() {
    return SharedPreferencesStorage.getLatestLongitudeCoordinate();
  }

  /// Retrieve the value of [double] from [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  ///
  static double getLatestLongitudeCoordinate() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final latestLongitudeResults = sharedPreferences.getDouble(
      SharedPreferencesStorage._latestLongitudeCoordinateKey,
    );

    if (latestLongitudeResults != null) {
      return latestLongitudeResults;
    } else {
      return 0.0;
    }
  }
}
