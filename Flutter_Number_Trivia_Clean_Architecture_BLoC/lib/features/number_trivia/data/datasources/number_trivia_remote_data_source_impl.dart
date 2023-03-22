import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:number_trivia_project/core/errors/exception.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/i_number_trivia_remote_data_source.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';

class NumberTriviaRemoteDataSourceImpl
    implements INumberTriviaRemoteDataSource {
  final http.Client httpClient;

  const NumberTriviaRemoteDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia({required int number}) {
    final url = 'http://numbersapi.com/$number';
    return _getNumberTriviaFromURL(url: url);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    const url = 'http://numbersapi.com/random';
    return _getNumberTriviaFromURL(url: url);
  }

  Future<NumberTriviaModel> _getNumberTriviaFromURL({
    required String url,
  }) async {
    final localUrl = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final response = await httpClient.get(localUrl, headers: headers);

    if (response.statusCode == 200) {
      try {
        return NumberTriviaModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
