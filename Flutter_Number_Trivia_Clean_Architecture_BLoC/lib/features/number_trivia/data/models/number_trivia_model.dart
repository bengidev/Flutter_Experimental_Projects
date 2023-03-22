import 'dart:convert';

import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'] as String,
      number: (json['number'] as num).toInt(),
    );
  }

  static Map<String, dynamic> toJson(NumberTriviaModel numberTriviaModel) {
    return {
      'text': numberTriviaModel.text,
      'number': numberTriviaModel.number,
    };
  }

  static String encodeToString(List<NumberTriviaModel> numberTriviaModels) {
    final encodeItems = json.encode(
      numberTriviaModels
          .map<Map<String, dynamic>>(
            (trivia) => NumberTriviaModel.toJson(trivia),
          )
          .toList(),
    );
    return encodeItems;
  }

  static List<NumberTriviaModel> decodeToList(String numberTriviaModels) {
    final decodeItems = json.decode(numberTriviaModels) as List<dynamic>;
    final modelResults = decodeItems
        .map<NumberTriviaModel>(
          (trivia) =>
              NumberTriviaModel.fromJson(trivia as Map<String, dynamic>),
        )
        .toList();
    return modelResults;
  }
}
