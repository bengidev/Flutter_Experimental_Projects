import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';

abstract class IRandomGeneratedTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<RandomGeneratedTriviaModel> getRandomGeneratedTrivia();
}
