import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';

abstract class IRandomGeneratedTriviaLocalDataSource {
  /// Gets the cached [RandomGeneratedTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<RandomGeneratedTriviaModel> getLastRandomGeneratedTrivia();

  Future<bool> cacheRandomGeneratedTrivia(
      RandomGeneratedTriviaModel randomTriviaToCache);
}
