import 'package:flutter/foundation.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class SharedPreferencesStorage {
  static const _onboardingCompletedKey = "ONBOARDING_COMPLETED_KEY";

  /// Test the static [setHasOnboardingCompleted] method
  /// of the [SharedPreferencesStorage]'s class.
  /// It will return the results from [setHasOnboardingCompleted].
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
  /// It will return the results from [getHasOnboardingCompleted].
  /// This method only available for testing purpose only.
  @visibleForTesting
  bool testGetWasOnboardingCompleted() {
    return SharedPreferencesStorage.getHasOnboardingCompleted();
  }

  /// Retrieve the value of [bool] from [SharedPreferences]'s instance.
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
}
