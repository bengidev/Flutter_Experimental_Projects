part of 'random_generated_trivia_bloc.dart';

enum RandomGeneratedTriviaStatus { initial, loading, success, failure }

extension RandomGeneratedTriviaStatusX on RandomGeneratedTriviaStatus {
  bool get isInitial => this == RandomGeneratedTriviaStatus.initial;
  bool get isLoading => this == RandomGeneratedTriviaStatus.loading;
  bool get isSuccess => this == RandomGeneratedTriviaStatus.success;
  bool get isFailure => this == RandomGeneratedTriviaStatus.failure;
}

class RandomGeneratedTriviaState extends Equatable {
  final RandomGeneratedTriviaStatus status;
  final RandomGeneratedTrivia? trivia;
  final String? failureMessage;

  const RandomGeneratedTriviaState({
    this.status = RandomGeneratedTriviaStatus.initial,
    this.trivia,
    this.failureMessage,
  });

  RandomGeneratedTriviaState copyWith({
    RandomGeneratedTriviaStatus? status,
    RandomGeneratedTrivia? trivia,
    String? failureMessage,
  }) {
    return RandomGeneratedTriviaState(
      status: status ?? this.status,
      trivia: trivia ?? this.trivia,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [status, trivia, failureMessage];
}
