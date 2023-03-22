import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';
import 'package:number_trivia_project/features/home/data/repositories/random_generated_trivia_repository_impl.dart';

class MockIRandomGeneratedTriviaLocalDataSource extends Mock
    implements IRandomGeneratedTriviaLocalDataSource {}

class MockIRandomGeneratedTriviaRemoteDataSource extends Mock
    implements IRandomGeneratedTriviaRemoteDataSource {}

class MockINetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late MockIRandomGeneratedTriviaLocalDataSource
      mockIRandomGeneratedTriviaLocalDataSource;
  late MockIRandomGeneratedTriviaRemoteDataSource
      mockIRandomGeneratedTriviaRemoteDataSource;
  late MockINetworkInfo mockINetworkInfo;
  late RandomGeneratedTriviaRepositoryImpl randomGeneratedTriviaRepositoryImpl;

  setUp(() {
    mockIRandomGeneratedTriviaLocalDataSource =
        MockIRandomGeneratedTriviaLocalDataSource();
    mockIRandomGeneratedTriviaRemoteDataSource =
        MockIRandomGeneratedTriviaRemoteDataSource();
    mockINetworkInfo = MockINetworkInfo();
    randomGeneratedTriviaRepositoryImpl = RandomGeneratedTriviaRepositoryImpl(
      localDataSource: mockIRandomGeneratedTriviaLocalDataSource,
      remoteDataSource: mockIRandomGeneratedTriviaRemoteDataSource,
      networkInfo: mockINetworkInfo,
    );
  });

  const tRandomGeneratedTriviaModel = RandomGeneratedTriviaModel(
    text: "test description",
    number: 1,
  );

  void setUpInternetConnectionAvailableTest(
    Function()? chainingTest,
  ) {
    group('Testing the internet connection is available', () {
      setUp(() {
        when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      chainingTest?.call();
    });
  }

  void setUpInternetConnectionUnavailableTest(
    Function()? chainingTest,
  ) {
    group('Testing the internet connection is unavailable', () {
      setUp(() {
        when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      chainingTest?.call();
    });
  }

  group('Testing the implementation of random generated trivia repository', () {
    setUpInternetConnectionAvailableTest(() {
      test(
          'Given the availability of internet is true '
          'When remote data source has no errors '
          'Then it should return random generated trivia model', () async {
        // ARRANGE
        when(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).thenAnswer((_) async => tRandomGeneratedTriviaModel);

        // ACT
        final result = await randomGeneratedTriviaRepositoryImpl
            .getRandomGeneratedTrivia();

        // ASSERT
        expect(result, const Right(tRandomGeneratedTriviaModel));
        verify(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).called(1);
      });

      test(
          'Given the availability of internet is true '
          'When remote data source has no errors '
          'Then it should save the data into cache using Shared Preferences',
          () async {
        // ARRANGE
        when(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).thenAnswer((_) async => tRandomGeneratedTriviaModel);

        // ACT
        await randomGeneratedTriviaRepositoryImpl.getRandomGeneratedTrivia();

        // ASSERT
        verify(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).called(1);
        verify(
          () => mockIRandomGeneratedTriviaLocalDataSource
              .cacheRandomGeneratedTrivia(tRandomGeneratedTriviaModel),
        ).called(1);
      });

      test(
          'Given the availability of internet is true '
          'When remote data source has errors of Server Exception '
          'Then it should return the Left of Server Failure', () async {
        // ARRANGE
        when(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).thenThrow((_) async => Left(ServerException()));

        // ACT
        final result = await randomGeneratedTriviaRepositoryImpl
            .getRandomGeneratedTrivia();

        // ASSERT
        expect(result, Left(ServerFailure()));
        verify(
          () => mockIRandomGeneratedTriviaRemoteDataSource
              .getRandomGeneratedTrivia(),
        ).called(1);
        verifyZeroInteractions(mockIRandomGeneratedTriviaLocalDataSource);
      });
    });

    setUpInternetConnectionUnavailableTest(() {
      test(
          'Given the availability of internet is false '
          'When local data source has no errors '
          'Then it should return last locally cached data when the cached data is present.',
          () async {
        // ARRANGE
        when(
          () => mockIRandomGeneratedTriviaLocalDataSource
              .getLastRandomGeneratedTrivia(),
        ).thenAnswer((_) async => tRandomGeneratedTriviaModel);

        // ACT
        final result = await randomGeneratedTriviaRepositoryImpl
            .getRandomGeneratedTrivia();

        // ASSERT
        expect(result, const Right(tRandomGeneratedTriviaModel));
        verify(
          () => mockIRandomGeneratedTriviaLocalDataSource
              .getLastRandomGeneratedTrivia(),
        ).called(1);
      });

      test(
          'Given the availability of internet is false '
          'When local data source has errors of Cache Exception '
          'Then it should return the Left of Cache Failure.', () async {
        // ARRANGE
        when(
          () => mockIRandomGeneratedTriviaLocalDataSource
              .getLastRandomGeneratedTrivia(),
        ).thenThrow(CacheException());

        // ACT
        final result = await randomGeneratedTriviaRepositoryImpl
            .getRandomGeneratedTrivia();

        // ASSERT
        expect(result, Left(CacheFailure()));
        verify(
          () => mockIRandomGeneratedTriviaLocalDataSource
              .getLastRandomGeneratedTrivia(),
        ).called(1);
      });
    });
  });
}
