import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/usecases/usecase.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';

class GetRandomNumberTriviaCase
    implements UseCase<EmptyParams, Future<Either<Failure, NumberTrivia>>> {
  final INumberTriviaRepository repository;

  const GetRandomNumberTriviaCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(EmptyParams arguments) async {
    return repository.getRandomNumberTrivia();
  }
}
