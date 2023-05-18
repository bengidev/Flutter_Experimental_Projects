import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static const _onboardingCompletedKey = "ONBOARDING_COMPLETED_KEY";
  static const _latestModelForwardFeatureKey =
      "LATEST_FORWARD_GEOCODING_MODEL_KEY";

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
  ForwardFeature testGetLatestModelForwardFeature() {
    return SharedPreferencesStorage.getLatestModelForwardFeature();
  }

  /// Retrieve the latest value of [ForwardFeature] from
  /// [SharedPreferences]'s instance.
  ///
  /// The [SharedPreferences]'s instance was obtained from
  /// the implementation of [GetIt].
  static ForwardFeature getLatestModelForwardFeature() {
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
      return const ForwardFeature(
        id: '',
        type: '',
        placeType: <String>[],
        relevance: 0,
        properties: ForwardProperty(wikidata: '', mapboxId: ''),
        text: '',
        placeName: '',
        bbox: <double>[],
        center: <double>[],
        geometry: ForwardGeometry(
          type: '',
          coordinates: <double>[],
        ),
        context: <ForwardContext>[],
      );
    }
  }
}
