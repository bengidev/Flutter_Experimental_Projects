import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  const NumberTriviaModel numberTriviaModel = NumberTriviaModel(
    text: 'test description',
    number: 1,
  );

  const tIntegerExternalRawData =
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
  const tDoubleExternalRawData =
      '{"text": "test description","number": 1.0, "found": true, "type": "trivia"}';
  const tStringNumberTriviaModels =
      '[{"text": "test description","number": 1, "found": true, "type": "trivia"}, '
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}, '
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}]';

  final tNumberTriviaModel = NumberTriviaModel.fromJson(
    json.decode(tIntegerExternalRawData) as Map<String, dynamic>,
  );

  final tNumberTriviaModels = <NumberTriviaModel>[
    tNumberTriviaModel,
    tNumberTriviaModel,
    tNumberTriviaModel,
  ];

  group("Testing number trivia model of fromJson", () {
    test(
      'Given the raw data from external API, '
      'When the data from external API was correct, '
      'Then it should return a valid model when to JSON number is an integer.',
      () async {
        /// ARRANGE

        /// ACT
        final result = NumberTriviaModel.fromJson(
            json.decode(tIntegerExternalRawData) as Map<String, dynamic>);

        /// ASSERT
        expect(result, numberTriviaModel);
        expect(numberTriviaModel, isA<NumberTrivia>());
      },
    );

    test(
      'Given the raw data from external API, '
      'When the data from external API was correct, '
      'Then it should return a valid model when to JSON number is regarded as a double.',
      () async {
        /// ARRANGE

        /// ACT
        final result = NumberTriviaModel.fromJson(
            json.decode(tDoubleExternalRawData) as Map<String, dynamic>);

        /// ASSERT
        expect(result, numberTriviaModel);
        expect(numberTriviaModel, isA<NumberTrivia>());
      },
    );
  });

  group("Testing number trivia model of toJson", () {
    test(
      'Given the map data of number trivia model, '
      'When the data from generated map was correct, '
      'Then it should return a JSON map containing the proper data.',
      () async {
        /// ARRANGE
        final Map<String, dynamic> expectedMap = {
          "text": "test description",
          "number": 1,
        };

        /// ACT
        final result = NumberTriviaModel.toJson(tNumberTriviaModel);

        /// ASSERT
        expect(result, expectedMap);
        expect(result, isA<Map<String, dynamic>>());
      },
    );
  });

  group("Testing number trivia model of encode", () {
    test(
      'Given the data string of number trivia models, '
      'When the format data was correct, '
      'Then it should return a string containing the proper data of number trivia model.',
      () async {
        /// ARRANGE

        /// ACT
        final result = NumberTriviaModel.encodeToString(tNumberTriviaModels);
        useLogger(object: result);

        /// ASSERT
        expect(result, isA<String>());
      },
    );
  });
  group("Testing number trivia model of decode", () {
    test(
      'Given the data of number trivia models, '
      'When the format data was correct, '
      'Then it should return a list containing the proper data of number trivia model.',
      () async {
        /// ARRANGE

        /// ACT
        final result =
            NumberTriviaModel.decodeToList(tStringNumberTriviaModels);
        useLogger(object: result);

        /// ASSERT
        expect(result, isA<List<NumberTriviaModel>>());
      },
    );
  });
}
