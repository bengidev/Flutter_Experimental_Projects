import 'package:dartz/dartz.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/repositories/i_number_trivia_repository.dart';

class CollectNumberTriviaRecordsCase
    implements
        UseCase<EmptyParams, Future<Either<Failure, List<NumberTrivia>>>> {
  final INumberTriviaRepository repository;

  const CollectNumberTriviaRecordsCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<NumberTrivia>>> call(
      EmptyParams parameters) async {
    final results = await repository.collectNumberTriviaRecords();
    return results;
  }
}
