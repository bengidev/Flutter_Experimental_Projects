import 'package:equatable/equatable.dart';

class RandomGeneratedTrivia extends Equatable {
  final String text;
  final int number;

  const RandomGeneratedTrivia({
    required this.text,
    required this.number,
  });

  @override
  List<Object?> get props => [text, number];
}
