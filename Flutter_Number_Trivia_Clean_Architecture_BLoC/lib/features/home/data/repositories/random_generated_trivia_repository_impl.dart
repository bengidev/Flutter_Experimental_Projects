import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/domain/repositories/i_random_generated_trivia_repository.dart';

class RandomGeneratedTriviaRepositoryImpl
    implements IRandomGeneratedTriviaRepository {
  final IRandomGeneratedTriviaLocalDataSource localDataSource;
  final IRandomGeneratedTriviaRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  const RandomGeneratedTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RandomGeneratedTrivia>>
      getRandomGeneratedTrivia() async {
    if (await _hasInternetConnection()) {
      try {
        final generatedTrivia =
            await remoteDataSource.getRandomGeneratedTrivia();
        await localDataSource.cacheRandomGeneratedTrivia(generatedTrivia);
        return Right(generatedTrivia);
      } catch (exception) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final generatedTrivia =
            await localDataSource.getLastRandomGeneratedTrivia();
        return Right(generatedTrivia);
      } catch (exception) {
        return Left(CacheFailure());
      }
    }
  }

  Future<bool> _hasInternetConnection() async {
    return networkInfo.isConnected;
  }
}
