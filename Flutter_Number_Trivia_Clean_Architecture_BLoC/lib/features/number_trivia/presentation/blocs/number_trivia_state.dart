part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NumberTriviaEmptyState extends NumberTriviaState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NumberTriviaErrorState extends NumberTriviaState {
  final String message;

  const NumberTriviaErrorState({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;
}

class NumberTriviaLoadingState extends NumberTriviaState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NumberTriviaLoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  const NumberTriviaLoadedState({
    required this.trivia,
  });

  @override
  List<Object> get props => [trivia];

  @override
  bool get stringify => true;
}
