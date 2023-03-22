import 'dart:convert';

import 'package:number_trivia_project/core/errors/exception.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_local_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberTriviaLocalDataSourceImpl implements INumberTriviaLocalDataSource {
  static const String _numberTriviaCacheCode = "NUMBER_TRIVIA_CACHE_CODE";
  static const String _numberTriviaStoreCode = "NUMBER_TRIVIA_STORE_CODE";
  final SharedPreferences sharedPreferences;

  const NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> cacheNumberTrivia({
    required NumberTriviaModel triviaToCache,
  }) async {
    // Caching the [NumberTriviaModel] into Shared Preferences.
    final operationResult = await sharedPreferences.setString(
      NumberTriviaLocalDataSourceImpl._numberTriviaCacheCode,
      // Encoding the value of [NumberTriviaModel] into the value of JSON String.
      json.encode(NumberTriviaModel.toJson(triviaToCache)),
    );
    return operationResult;
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    // Load the value of JSON String from Shared Preferences.
    final jsonString = sharedPreferences
        .getString(NumberTriviaLocalDataSourceImpl._numberTriviaCacheCode);

    // Return the converted value of JSON String into [NumberTriviaModel],
    // When the JSON String data was available.
    if (jsonString != null) {
      try {
        return Future<NumberTriviaModel>.value(
          NumberTriviaModel.fromJson(
            json.decode(jsonString) as Map<String, dynamic>,
          ),
        );
      } catch (e) {
        throw CacheException();
      }
      // Throw [CacheException] when the JSON String data was unavailable.
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> storeNumberTriviaRecord({
    required NumberTriviaModel triviaToStore,
  }) {
    // Load the value of JSON String from Shared Preferences.
    final loadNumberTriviaRecords = sharedPreferences
        .getString(NumberTriviaLocalDataSourceImpl._numberTriviaStoreCode);
    var numberTriviaRecords = <NumberTriviaModel>[];

    // Convert the value of JSON String into the [List<NumberTriviaModel>],
    // When the value of JSON String was available.
    // Otherwise it will create a new [List<NumberTriviaModel>] to insert the new value.
    if (loadNumberTriviaRecords != null) {
      numberTriviaRecords =
          NumberTriviaModel.decodeToList(loadNumberTriviaRecords);
    }
    numberTriviaRecords.add(triviaToStore);

    // Convert the value of [List<NumberTriviaModel>] into the JSON String.
    final triviasToString =
        NumberTriviaModel.encodeToString(numberTriviaRecords);

    // Insert the value of JSON String into Shared Preferences,
    // And return its Future value.
    final operationResult = sharedPreferences.setString(
      NumberTriviaLocalDataSourceImpl._numberTriviaStoreCode,
      triviasToString,
    );
    return operationResult;
  }

  @override
  Future<List<NumberTriviaModel>> collectNumberTriviaRecords() {
    // Load the value of JSON String from Shared Preferences.
    final savedString = sharedPreferences
        .getString(NumberTriviaLocalDataSourceImpl._numberTriviaStoreCode);

    // Return the converted value of String into List<[NumberTriviaModel]>,
    // when the String data was available.
    if (savedString != null) {
      try {
        // Decode the saved string into List<[NumberTriviaModel]>,
        // when String data was available, then return it.
        return Future<List<NumberTriviaModel>>.value(
          NumberTriviaModel.decodeToList(savedString),
        );
      } catch (e) {
        throw CacheException();
      }
      // Throw [CacheException] when the String data was unavailable.
    } else {
      throw CacheException();
    }
  }
}
