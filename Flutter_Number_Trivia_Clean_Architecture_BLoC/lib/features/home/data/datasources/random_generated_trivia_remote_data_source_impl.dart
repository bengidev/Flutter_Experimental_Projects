// coverage:ignore-file
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/i_random_generated_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';

class RandomGeneratedTriviaRemoteDataSourceImpl
    implements IRandomGeneratedTriviaRemoteDataSource {
  final http.Client httpClient;

  RandomGeneratedTriviaRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<RandomGeneratedTriviaModel> getRandomGeneratedTrivia() async {
    return _getTriviaFromUrl(
      url: 'http://numbersapi.com/${_generateRandomNumber()}',
    );
  }

  Future<RandomGeneratedTriviaModel> _getTriviaFromUrl({
    required String url,
  }) async {
    final response = await httpClient.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return RandomGeneratedTriviaModel.fromMap(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }

// Generates a positive random integer uniformly distributed on the range
// from [min], inclusive, to [max], exclusive.
  @visibleForTesting
  int generateRandomNumberTest([int min = 0, int max = 1000]) =>
      _generateRandomNumber(min, max);

  int _generateRandomNumber([int min = 0, int max = 1000]) {
    final random = Random();
    return min + random.nextInt(max - min);
  }
}
