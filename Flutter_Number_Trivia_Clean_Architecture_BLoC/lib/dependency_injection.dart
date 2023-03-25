// coverage:ignore-file

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:number_trivia_project/application.dart';
import 'package:number_trivia_project/core/styles/app_styles.dart';
import 'package:number_trivia_project/core/utilities/input_converter.dart';
import 'package:number_trivia_project/core/utilities/network_info.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/home/data/datasources/random_generated_trivia_local_data_source_impl.dart';
import 'package:number_trivia_project/features/home/data/datasources/random_generated_trivia_remote_data_source_impl.dart';
import 'package:number_trivia_project/features/home/data/repositories/random_generated_trivia_repository_impl.dart';
import 'package:number_trivia_project/features/home/domain/repositories/i_random_generated_trivia_repository.dart';
import 'package:number_trivia_project/features/home/domain/usecases/get_random_generated_trivia_case.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:number_trivia_project/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/collect_number_trivia_records_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_concrete_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_random_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global helpers for readability
GetIt get $serviceLocator => GetIt.instance;

AppStyles get $styles => Application.style;

/// Create singletons (logic and services) that can be shared across the app.
Future<void> initializeServiceLocator() async {
  // Core
  $serviceLocator.registerLazySingleton<InputConverter>(
    () => InputConverter(),
  );
  $serviceLocator.registerLazySingleton<INetworkInfo>(
    () => NetworkInfoImpl(
      internetConnectionChecker: $serviceLocator(),
    ),
  );

  // External
  $serviceLocator.registerSingletonAsync<SharedPreferences>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  });
  $serviceLocator.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
  $serviceLocator.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  // Features - Number Trivia
  // BLoC
  $serviceLocator.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      concreteTrivia: $serviceLocator(),
      randomTrivia: $serviceLocator(),
      collectTriviaRecords: $serviceLocator(),
      inputConverter: $serviceLocator(),
    ),
  );

  // Use Cases
  $serviceLocator.registerLazySingleton<GetConcreteNumberTriviaCase>(
    () => GetConcreteNumberTriviaCase(
      repository: $serviceLocator(),
    ),
  );
  $serviceLocator.registerLazySingleton<GetRandomNumberTriviaCase>(
    () => GetRandomNumberTriviaCase(
      repository: $serviceLocator(),
    ),
  );
  $serviceLocator.registerLazySingleton<CollectNumberTriviaRecordsCase>(
    () => CollectNumberTriviaRecordsCase(repository: $serviceLocator()),
  );

  // Repository
  $serviceLocator.registerLazySingleton<INumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: $serviceLocator(),
      localDataSource: $serviceLocator(),
      networkInfo: $serviceLocator(),
    ),
  );

  // Data Sources
  $serviceLocator.registerLazySingleton<INumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      httpClient: $serviceLocator(),
    ),
  );
  $serviceLocator.registerLazySingleton<INumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: $serviceLocator(),
    ),
  );

  // Features - Home
  // BLoC
  $serviceLocator.registerFactory<RandomGeneratedTriviaBloc>(
    () => RandomGeneratedTriviaBloc(randomGeneratedTrivia: $serviceLocator()),
  );

  // Use Cases
  $serviceLocator.registerLazySingleton<GetRandomGeneratedTriviaCase>(
    () => GetRandomGeneratedTriviaCase(
      repository: $serviceLocator(),
    ),
  );

  // Repository
  $serviceLocator.registerLazySingleton<IRandomGeneratedTriviaRepository>(
    () => RandomGeneratedTriviaRepositoryImpl(
      remoteDataSource: $serviceLocator(),
      localDataSource: $serviceLocator(),
      networkInfo: $serviceLocator(),
    ),
  );

  // Data Sources
  $serviceLocator.registerLazySingleton<IRandomGeneratedTriviaRemoteDataSource>(
    () => RandomGeneratedTriviaRemoteDataSourceImpl(
      httpClient: $serviceLocator(),
    ),
  );
  $serviceLocator.registerLazySingleton<IRandomGeneratedTriviaLocalDataSource>(
    () => RandomGeneratedTriviaLocalDataSourceImpl(
      sharedPreferences: $serviceLocator(),
    ),
  );

  // Wait until all dependency registration was finished.
  await $serviceLocator.allReady();
}
