import 'package:dartz/dartz.dart';
import 'package:flutter_weather_sense_mvvm_bloc/application.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/use_cases/use_cases_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/data_sources/daily_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/repositories/daily_weather_forecast_repository_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/usecases/find_daily_weather_forecast_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/view_models/daily_weather_forecast_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/forward_geocoding_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/data_sources/hourly_weather_forecast_remote_data_source_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/forward_geocoding_repository_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/repositories/hourly_weather_forecast_repository_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/find_hourly_weather_forecast_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global helpers for the ease of Service Locator's usage.
GetIt get $serviceLocator => GetIt.instance;

/// Global helpers for the ease of AppStyles' usage.
AppStyles get $styles => Application.styles;

/// Global helpers for the ease of MapBox Access Token's usage.
String get $mapBoxAccessToken =>
    'pk.eyJ1Ijoic3luZGljYXRlMDE3IiwiYSI6ImNsZ2FmYjdodTA4NnMzcnByYjhneHFyd2oifQ.GhpidZgojTsBEGluIkWvTw';

/// Global helpers for the ease of MapBox Access Style URLs' usage.
String get $mapBoxStyleUrl =>
    'mapbox://styles/syndicate017/clhpiogvt01vj01pg3uux95fo';

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
      () => HomeBloc(
        searchLocationCase: $serviceLocator(),
        findHourlyWeatherForecastCase: $serviceLocator(),
      ),
    );

    // Use Cases
    $serviceLocator.registerLazySingleton<SearchLocationCase>(
      () => SearchLocationCase(forwardGeocodingRepository: $serviceLocator()),
    );

    $serviceLocator.registerLazySingleton<FindHourlyWeatherForecastCase>(
      () => FindHourlyWeatherForecastCase(
        hourlyWeatherForecastRepository: $serviceLocator(),
      ),
    );

    // Repositories
    $serviceLocator.registerLazySingleton<IForwardGeocodingRepository>(
      () => ForwardGeocodingRepositoryImpl(remoteDataSource: $serviceLocator()),
    );

    $serviceLocator.registerLazySingleton<IHourlyWeatherForecastRepository>(
      () => HourlyWeatherForecastRepositoryImpl(
        remoteDataSource: $serviceLocator(),
      ),
    );

    // Data Sources
    $serviceLocator.registerLazySingleton<IForwardGeocodingRemoteDataSource>(
      () => ForwardGeocodingRemoteDataSourceImpl(
        httpClient: $serviceLocator(),
      ),
    );

    $serviceLocator
        .registerLazySingleton<IHourlyWeatherForecastRemoteDataSource>(
      () => HourlyWeatherForecastRemoteDataSourceImpl(
        httpClient: $serviceLocator(),
      ),
    );

    //Features
    // Daily Weather Forecast
    // View Models - Bloc
    $serviceLocator.registerFactory<DailyWeatherForecastBloc>(
      () => DailyWeatherForecastBloc(
        findDailyWeatherForecastCase: $serviceLocator(),
      ),
    );

    // Use Cases
    $serviceLocator.registerLazySingleton<
        IUseCase<DailyWeatherForecastParameter,
            Future<Either<Failure, DailyWeatherForecastModel>>>>(
      () => FindDailyWeatherForecastCase(
        dailyWeatherForecastRepository: $serviceLocator(),
      ),
    );

    // Repositories
    $serviceLocator.registerLazySingleton<IDailyWeatherForecastRepository>(
      () => DailyWeatherForecastRepositoryImpl(
        remoteDataSource: $serviceLocator(),
      ),
    );

    // Data Sources
    $serviceLocator
        .registerLazySingleton<IDailyWeatherForecastRemoteDataSource>(
      () => DailyWeatherForecastRemoteDataSourceImpl(
        httpClient: $serviceLocator(),
      ),
    );

    // Wait until all dependency registration was completed.
    await $serviceLocator.allReady();
  }
}
