import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';

abstract class INumberTriviaLocalDataSource {
  /// Saving the cache of [NumberTriviaModel] when successfully retrieve
  /// the results from external API.
  ///
  /// Throws [CacheException] if the operation was failure.
  Future<bool> cacheNumberTrivia({
    required NumberTriviaModel triviaToCache,
  });

  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Storing the [NumberTriviaModel] when the data records was available
  /// into local device storage.
  ///
  /// Throws [CacheException] if the operation was failure.
  Future<bool> storeNumberTriviaRecord({
    required NumberTriviaModel triviaToStore,
  });

  /// Collects the stored [NumberTriviaModel]s when the data records was available
  /// from local device storage.
  ///
  /// Throws [CacheException] if the operation was failure.
  Future<List<NumberTriviaModel>> collectNumberTriviaRecords();
}
