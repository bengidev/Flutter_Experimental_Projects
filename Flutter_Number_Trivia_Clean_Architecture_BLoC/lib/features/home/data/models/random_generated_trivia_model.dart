import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';

class RandomGeneratedTriviaModel extends RandomGeneratedTrivia {
  const RandomGeneratedTriviaModel({
    required super.text,
    required super.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': number,
    };
  }

  factory RandomGeneratedTriviaModel.fromMap(Map<String, dynamic> map) {
    return RandomGeneratedTriviaModel(
      text: map['text'] as String,
      number: (map['number'] as num).toInt(),
    );
  }
}
