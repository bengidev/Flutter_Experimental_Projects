part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForConcreteNumberEvent({
    required this.numberString,
  });

  @override
  List<Object> get props => [numberString];
}

class GetTriviaForRandomNumberEvent extends NumberTriviaEvent {
  @override
  List<Object> get props => [];
}
