import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';

abstract class INumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia({
    required int number,
  });

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();

  Future<Either<Failure, List<NumberTrivia>>> collectNumberTriviaRecords();
}
