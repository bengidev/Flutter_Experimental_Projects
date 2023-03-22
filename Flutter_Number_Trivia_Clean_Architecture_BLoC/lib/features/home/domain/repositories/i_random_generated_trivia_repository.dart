import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';

abstract class IRandomGeneratedTriviaRepository {
  Future<Either<Failure, RandomGeneratedTrivia>> getRandomGeneratedTrivia();
}
