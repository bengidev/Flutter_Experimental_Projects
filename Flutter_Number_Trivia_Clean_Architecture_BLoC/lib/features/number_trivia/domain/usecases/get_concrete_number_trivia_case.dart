import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/usecases/usecase.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';

class GetConcreteNumberTriviaCase
    implements UseCase<ConcreteParams, Future<Either<Failure, NumberTrivia>>> {
  final INumberTriviaRepository repository;

  const GetConcreteNumberTriviaCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(ConcreteParams parameters) {
    return repository.getConcreteNumberTrivia(number: parameters.number);
  }
}

class ConcreteParams extends Equatable {
  final int number;

  const ConcreteParams({
    required this.number,
  });

  @override
  List<Object?> get props => [number];

  @override
  bool get stringify => true;
}
