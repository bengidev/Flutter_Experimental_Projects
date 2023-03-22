import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';

void main() {
  const tRandomGeneratedTriviaModel =
      RandomGeneratedTriviaModel(text: "test description", number: 1);

  test(
      'Given random generated trivia model was available '
      'When that data was received '
      'Then it should be a subclass of RandomGeneratedTrivia entity', () async {
    // ARRANGE

    // ACT

    // ASSERT
    expect(tRandomGeneratedTriviaModel, isA<RandomGeneratedTrivia>());
  });

  group('Encoding and Decoding JSON object of RandomGeneratedTriviaModel', () {
    test(
        'Given random generated trivia model was available '
        'When that data was received '
        'Then it should return a valid model when the JSON number is an integer',
        () async {
      // ARRANGE
      const rawJson =
          '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
      final jsonMap = json.decode(rawJson) as Map<String, dynamic>;

      // ACT
      final result = RandomGeneratedTriviaModel.fromMap(jsonMap);

      // ASSERT
      expect(result, tRandomGeneratedTriviaModel);
    });

    test(
        'Given random generated trivia model was available '
        'When that data was received '
        'Then it should return a valid model when the JSON number is an double',
        () async {
      // ARRANGE
      const rawJson =
          '{"text": "test description","number": 1.0, "found": true, "type": "trivia"}';
      final jsonMap = json.decode(rawJson) as Map<String, dynamic>;

      // ACT
      final result = RandomGeneratedTriviaModel.fromMap(jsonMap);

      // ASSERT
      expect(result, tRandomGeneratedTriviaModel);
    });

    test(
        'Given random generated trivia model was available '
        'When that data was received '
        'Then it should return a JSON map containing the proper data',
        () async {
      // ARRANGE
      final result = tRandomGeneratedTriviaModel.toMap();

      // ACT
      const expectedJson = <String, dynamic>{
        'text': "test description",
        'number': 1,
      };

      // ASSERT
      expect(result, expectedJson);
    });
  });
}
