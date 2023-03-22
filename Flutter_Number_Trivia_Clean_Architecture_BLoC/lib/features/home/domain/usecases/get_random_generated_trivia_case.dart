import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/domain/repositories/i_random_generated_trivia_repository.dart';

class GetRandomGeneratedTriviaCase
    implements
        UseCase<EmptyParams, Future<Either<Failure, RandomGeneratedTrivia>>> {
  final IRandomGeneratedTriviaRepository repository;

  GetRandomGeneratedTriviaCase({required this.repository});

  @override
  Future<Either<Failure, RandomGeneratedTrivia>> call(
    EmptyParams params,
  ) async {
    return repository.getRandomGeneratedTrivia();
  }
}
