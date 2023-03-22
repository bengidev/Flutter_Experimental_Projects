import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/errors/exception.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/utilities/logger.dart';
import 'package:number_trivia_project/core/utilities/network_info.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements INumberTriviaRepository {
  final INumberTriviaRemoteDataSource remoteDataSource;
  final INumberTriviaLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  const NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia({
    required int number,
  }) {
    return _getTriviaEitherResults(
      triviaRequestProcedure: () =>
          remoteDataSource.getConcreteNumberTrivia(number: number),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTriviaEitherResults(
      triviaRequestProcedure: () => remoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getTriviaEitherResults({
    required Future<NumberTriviaModel> Function() triviaRequestProcedure,
  }) async {
    if (await networkInfo.isConnected) {
      return _numberTriviaOnlineResult(
        procedure: triviaRequestProcedure,
      );
    } else {
      return _numberTriviaOfflineResult();
    }
  }

  Future<Either<Failure, NumberTrivia>> _numberTriviaOnlineResult({
    required Future<NumberTriviaModel> Function() procedure,
  }) async {
    try {
      final remoteTrivia = await procedure();
      await localDataSource.cacheNumberTrivia(
        triviaToCache: remoteTrivia,
      );
      await localDataSource.storeNumberTriviaRecord(
        triviaToStore: remoteTrivia,
      );
      return Right(remoteTrivia);
    } on ServerException catch (e) {
      useLogger(object: "ServerException: $e");
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NumberTrivia>> _numberTriviaOfflineResult() async {
    try {
      final localTrivia = await localDataSource.getLastNumberTrivia();
      return Right(localTrivia);
    } on CacheException catch (e) {
      useLogger(object: "CacheException: $e");
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<NumberTrivia>>>
      collectNumberTriviaRecords() async {
    try {
      final triviaRecords = await localDataSource.collectNumberTriviaRecords();
      return Right(triviaRecords);
    } on CacheException catch (e) {
      useLogger(object: "CacheException: $e");
      return Left(CacheFailure());
    }
  }
}
