import 'package:flutter_weather_sense_mvvm_bloc/application.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repositories_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository_impl.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global helpers for the ease of Service Locator's readability.
GetIt get $serviceLocator => GetIt.instance;

/// Global helpers for the ease of AppStyles' readability.
AppStyles get $styles => Application.styles;

class DependencyInjection {
  /// Create singletons (logic and services) that can be shared across the app.
  ///
  /// Run this function inside your main function and wait until the initialization process
  /// has been completed.

  static Future<void> initializeDependencies() async {
    // Core
    $serviceLocator.registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    );
    $serviceLocator.registerSingleton<http.Client>(http.Client());
    $serviceLocator.registerSingleton<InternetConnectionChecker>(
      InternetConnectionChecker(),
    );
    $serviceLocator.registerLazySingleton<NetworkInformation>(
      () => NetworkInformation(internetChecker: $serviceLocator()),
    );

    //Features
    // Home
    // View Models - Bloc
    $serviceLocator.registerFactory<HomeBloc>(
      () => HomeBloc(searchLocationCase: $serviceLocator()),
    );

    // Use Cases
    $serviceLocator.registerLazySingleton<SearchLocationCase>(
      () => SearchLocationCase(forwardGeocodingRepository: $serviceLocator()),
    );

    // Repositories
    $serviceLocator.registerLazySingleton<IForwardGeocodingRepository>(
      () => ForwardGeocodingRepositoryImpl(remoteDataSource: $serviceLocator()),
    );

    // Data Sources
    $serviceLocator.registerLazySingleton<IForwardGeocodingRemoteDataSource>(
      () => ForwardGeocodingRemoteDataSourceImpl(
        httpClient: $serviceLocator(),
      ),
    );

    // Wait until all dependency registration was completed.
    await $serviceLocator.allReady();
  }
}
