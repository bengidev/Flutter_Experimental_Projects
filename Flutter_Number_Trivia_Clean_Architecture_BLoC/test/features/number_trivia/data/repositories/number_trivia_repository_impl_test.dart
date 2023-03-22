import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_project/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';

class MockINumberTriviaRemoteDataSource extends Mock
    implements INumberTriviaRemoteDataSource {}

class MockINumberTriviaLocalDataSource extends Mock
    implements INumberTriviaLocalDataSource {}

class MockINetworkInfo extends Mock implements INetworkInfo {}

void main() {
  late MockINumberTriviaRemoteDataSource mockINumberTriviaRemoteDataSource;
  late MockINumberTriviaLocalDataSource mockINumberTriviaLocalDataSource;
  late MockINetworkInfo mockINetworkInfo;
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;

  setUp(
    () {
      mockINumberTriviaRemoteDataSource = MockINumberTriviaRemoteDataSource();
      mockINumberTriviaLocalDataSource = MockINumberTriviaLocalDataSource();
      mockINetworkInfo = MockINetworkInfo();
      numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
        remoteDataSource: mockINumberTriviaRemoteDataSource,
        localDataSource: mockINumberTriviaLocalDataSource,
        networkInfo: mockINetworkInfo,
      );
    },
  );

  setUpAll(() {
    registerFallbackValue(
      const NumberTriviaModel(text: 'test description', number: 1),
    );
  });

  const tNumber = 1;
  const tNumberTriviaModel = NumberTriviaModel(
    text: "test",
    number: tNumber,
  );
  const tNumberTriviaModelRecords = <NumberTriviaModel>[
    tNumberTriviaModel,
    tNumberTriviaModel,
    tNumberTriviaModel,
  ];
  const NumberTrivia testNumberTrivia = tNumberTriviaModel;

  void setUpTestsOnline(void Function() body) {
    group("Device Status is Online", () {
      setUp(() {
        when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void setUpTestsOffline(void Function() body) {
    group("Device Status is Offline", () {
      setUp(() {
        when(() => mockINetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void setUpRightRemoteDataSource() {
    when(
      () => mockINumberTriviaRemoteDataSource.getConcreteNumberTrivia(
        number: any(named: 'number'),
      ),
    ).thenAnswer((_) async => tNumberTriviaModel);
    when(() => mockINumberTriviaRemoteDataSource.getRandomNumberTrivia())
        .thenAnswer((_) async => tNumberTriviaModel);
  }

  void setUpRightLocalDataSource() {
    when(
      () => mockINumberTriviaLocalDataSource.cacheNumberTrivia(
        triviaToCache: any(named: 'triviaToCache'),
      ),
    ).thenAnswer((_) async => true);
    when(() => mockINumberTriviaLocalDataSource.getLastNumberTrivia())
        .thenAnswer((_) async => tNumberTriviaModel);
    when(
      () => mockINumberTriviaLocalDataSource.storeNumberTriviaRecord(
        triviaToStore: any(named: 'triviaToStore'),
      ),
    ).thenAnswer((_) async => true);
    when(() => mockINumberTriviaLocalDataSource.collectNumberTriviaRecords())
        .thenAnswer((_) async => tNumberTriviaModelRecords);
  }

  void setUpLeftRemoteDataSource() {
    when(
      () => mockINumberTriviaRemoteDataSource.getConcreteNumberTrivia(
        number: any(named: 'number'),
      ),
    ).thenThrow(ServerException());
    when(() => mockINumberTriviaRemoteDataSource.getRandomNumberTrivia())
        .thenThrow(ServerException());
  }

  void setUpLeftLocalDataSource() {
    when(
      () => mockINumberTriviaLocalDataSource.cacheNumberTrivia(
        triviaToCache: any(named: 'triviaToCache'),
      ),
    ).thenThrow(CacheException());
    when(() => mockINumberTriviaLocalDataSource.getLastNumberTrivia())
        .thenThrow(CacheException());
    when(
      () => mockINumberTriviaLocalDataSource.storeNumberTriviaRecord(
        triviaToStore: any(named: 'triviaToStore'),
      ),
    ).thenAnswer((_) async => false);
    when(() => mockINumberTriviaLocalDataSource.collectNumberTriviaRecords())
        .thenThrow(CacheException());
  }

  group("Testing for getConcreteNumberTrivia use case", () {
    setUpTestsOnline(() {
      test(
        'Given the number parameter of get concrete number trivia, '
        'When the network info connection was available, '
        'Then it should return remote data when the call to remote data source is successful.',
        () async {
          // ARRANGE
          setUpRightRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          final result = await numberTriviaRepositoryImpl
              .getConcreteNumberTrivia(number: tNumber);

          // ASSERT
          expect(result, const Right(tNumberTriviaModel));
          verify(() => mockINetworkInfo.isConnected).called(1);
        },
      );

      test(
        'Given the number parameter of get concrete number trivia, '
        'When the network info connection was available, '
        'Then it should cache the data locally when the call to remote data source is successful.',
        () async {
          // ARRANGE
          setUpRightRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          await numberTriviaRepositoryImpl.getConcreteNumberTrivia(
            number: tNumber,
          );

          // ASSERT
          verify(() => mockINetworkInfo.isConnected).called(1);
          verify(
            () => mockINumberTriviaRemoteDataSource.getConcreteNumberTrivia(
              number: any(named: 'number'),
            ),
          ).called(1);
          verify(
            () => mockINumberTriviaLocalDataSource.cacheNumberTrivia(
              triviaToCache: any(named: 'triviaToCache'),
            ),
          ).called(1);
        },
      );

      test(
        'Given the number parameter of get concrete number trivia, '
        'When the network info connection was unavailable, '
        'Then it should return server failure when the call to remote data source is unsuccessful.',
        () async {
          // ARRANGE
          setUpLeftRemoteDataSource();
          setUpLeftLocalDataSource();

          // ACT
          final result = await numberTriviaRepositoryImpl
              .getConcreteNumberTrivia(number: tNumber);

          // ASSERT
          expect(result, Left(ServerFailure()));
          verify(
            () => mockINumberTriviaRemoteDataSource.getConcreteNumberTrivia(
              number: any(named: 'number'),
            ),
          ).called(1);
          verifyZeroInteractions(mockINumberTriviaLocalDataSource);
        },
      );

      setUpTestsOffline(() {
        test(
          'Given the number parameter of get concrete number trivia, '
          'When the network info connection was unavailable, '
          'Then it should return last locally cached data when the cached data is present.',
          () async {
            // ARRANGE
            setUpLeftRemoteDataSource();
            setUpRightLocalDataSource();

            // ACT
            final result = await numberTriviaRepositoryImpl
                .getConcreteNumberTrivia(number: tNumber);

            // ASSERT
            expect(result, const Right(tNumberTriviaModel));
            verify(() => mockINumberTriviaLocalDataSource.getLastNumberTrivia())
                .called(1);
            verifyZeroInteractions(mockINumberTriviaRemoteDataSource);
          },
        );

        test(
          'Given the number parameter of get concrete number trivia, '
          'When the network info connection was unavailable, '
          'Then it should return CacheFailure when there is no cached data was present.',
          () async {
            // ARRANGE
            setUpRightRemoteDataSource();
            setUpLeftLocalDataSource();

            // ACT
            final result = await numberTriviaRepositoryImpl
                .getConcreteNumberTrivia(number: tNumber);

            // ASSERT
            expect(result, Left(CacheFailure()));
            verify(
              () => mockINumberTriviaLocalDataSource.getLastNumberTrivia(),
            );
            verifyZeroInteractions(mockINumberTriviaRemoteDataSource);
          },
        );
      });
    });
  });

  group("Testing for getRandomNumberTrivia use case", () {
    setUpTestsOnline(() {
      test(
        'Given the random number trivia, '
        'When the network info connection was available, '
        'Then it should return remote data when the call to remote data source is successful.',
        () async {
          // ARRANGE
          setUpRightRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          final result =
              await numberTriviaRepositoryImpl.getRandomNumberTrivia();

          // ASSERT
          verify(() => mockINetworkInfo.isConnected).called(1);
          verify(
            () => mockINumberTriviaRemoteDataSource.getRandomNumberTrivia(),
          ).called(1);
          expect(result, const Right(tNumberTriviaModel));
        },
      );

      test(
        'Given the random number trivia, '
        'When the network info connection was available, '
        'Then it should cache the data locally when the call to remote data source is successful.',
        () async {
          // ARRANGE
          setUpRightRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          await numberTriviaRepositoryImpl.getRandomNumberTrivia();

          // ASSERT
          verify(() => mockINetworkInfo.isConnected).called(1);
          verify(
            () => mockINumberTriviaRemoteDataSource.getRandomNumberTrivia(),
          ).called(1);
          verify(
            () => mockINumberTriviaLocalDataSource.cacheNumberTrivia(
              triviaToCache: any(named: 'triviaToCache'),
            ),
          ).called(1);
          verify(
            () => mockINumberTriviaLocalDataSource.storeNumberTriviaRecord(
              triviaToStore: any(named: 'triviaToStore'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockINumberTriviaLocalDataSource);
        },
      );

      test(
        'Given the random number trivia, '
        'When the network info connection was available, '
        'Then it should return server failure when the call to remote data source is unsuccessful.',
        () async {
          // ARRANGE
          setUpLeftRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          final result =
              await numberTriviaRepositoryImpl.getRandomNumberTrivia();

          // ASSERT
          expect(result, Left(ServerFailure()));
          verify(() => mockINetworkInfo.isConnected).called(1);
          verify(
            () => mockINumberTriviaRemoteDataSource.getRandomNumberTrivia(),
          ).called(1);
          verifyNoMoreInteractions(mockINumberTriviaLocalDataSource);
        },
      );
    });

    setUpTestsOffline(() {
      test(
        'Given the random number trivia, '
        'When the network info connection was unavailable, '
        'Then it should return return last locally cached data when the cached data is present.',
        () async {
          // ARRANGE
          setUpLeftRemoteDataSource();
          setUpRightLocalDataSource();

          // ACT
          final result =
              await numberTriviaRepositoryImpl.getRandomNumberTrivia();

          // ASSERT
          expect(result, const Right(tNumberTriviaModel));
          verify(() => mockINetworkInfo.isConnected).called(1);
          verify(() => mockINumberTriviaLocalDataSource.getLastNumberTrivia())
              .called(1);
          verifyZeroInteractions(mockINumberTriviaRemoteDataSource);
        },
      );

      test(
        'Given the random number trivia, '
        'When the network info connection was unavailable, '
        'Then it should return CacheFailure when there is no cached data was present.',
        () async {
          // ARRANGE
          setUpLeftRemoteDataSource();
          setUpLeftLocalDataSource();

          // ACT
          final result =
              await numberTriviaRepositoryImpl.getRandomNumberTrivia();

          // ASSERT
          expect(result, Left(CacheFailure()));
          verify(() => mockINumberTriviaLocalDataSource.getLastNumberTrivia())
              .called(1);
          verifyZeroInteractions(mockINumberTriviaRemoteDataSource);
        },
      );
    });
  });

  group("Testing for collectNumberTriviaRecords use case", () {
    test(
        'Given the data of number trivia, '
        'When the executed procedure has no errors, '
        'Then it should return the records of number trivia.', () async {
      // ARRANGE
      setUpRightRemoteDataSource();
      setUpRightLocalDataSource();

      // ACT
      final results =
          await numberTriviaRepositoryImpl.collectNumberTriviaRecords();

      // ASSERT
      expect(results, const Right(tNumberTriviaModelRecords));
      verify(
        () => mockINumberTriviaLocalDataSource.collectNumberTriviaRecords(),
      ).called(1);
    });

    test(
        'Given the data of number trivia, '
        'When the executed procedure has errors, '
        'Then it should return the cache failure.', () async {
      // ARRANGE
      setUpLeftRemoteDataSource();
      setUpLeftLocalDataSource();

      // ACT
      final results =
          await numberTriviaRepositoryImpl.collectNumberTriviaRecords();

      // ASSERT
      expect(results, Left(CacheFailure()));
      verify(
        () => mockINumberTriviaLocalDataSource.collectNumberTriviaRecords(),
      ).called(1);
      verifyNoMoreInteractions(mockINumberTriviaRemoteDataSource);
      verifyNoMoreInteractions(mockINumberTriviaLocalDataSource);
    });
  });
}
