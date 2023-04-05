import 'package:flutter_weather_sense_mvvm_bloc/application.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global helpers for the ease of readability
GetIt get $serviceLocator => GetIt.instance;

AppStyles get $appStyles => Application.styles;

/// Create singletons (logic and services) that can be shared across the app.
///
/// Run this function inside your main function and wait until the initialization process
/// has been completed.
///
Future<void> initializeServiceLocator() async {
  // Core
  $serviceLocator.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );

  // Wait until all dependency registration was completed.
  await $serviceLocator.allReady();
}
