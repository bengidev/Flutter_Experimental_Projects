import 'dart:convert';

import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RandomGeneratedTriviaLocalDataSourceImpl
    implements IRandomGeneratedTriviaLocalDataSource {
  static const dataSourceKey = "Random_Generate_Trivia_Shared_Preferences";
  final SharedPreferences sharedPreferences;

  const RandomGeneratedTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> cacheRandomGeneratedTrivia(
    RandomGeneratedTriviaModel randomTriviaToCache,
  ) async {
    final dataWasSavedSuccessfully = await sharedPreferences.setString(
      RandomGeneratedTriviaLocalDataSourceImpl.dataSourceKey,
      json.encode(randomTriviaToCache.toMap()),
    );
    if (dataWasSavedSuccessfully) {
      return Future.delayed(
        const Duration(seconds: 1),
        () => true,
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<RandomGeneratedTriviaModel> getLastRandomGeneratedTrivia() async {
    final hasStoredData = sharedPreferences
        .getString(RandomGeneratedTriviaLocalDataSourceImpl.dataSourceKey);
    if (hasStoredData != null && hasStoredData.isNotEmpty) {
      return Future.delayed(
        const Duration(seconds: 1),
        () => RandomGeneratedTriviaModel.fromMap(
          json.decode(hasStoredData) as Map<String, dynamic>,
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
