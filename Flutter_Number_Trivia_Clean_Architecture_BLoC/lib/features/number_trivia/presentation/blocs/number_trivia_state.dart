part of 'number_trivia_bloc.dart';

enum NumberTriviaStatus { initial, loading, success, failure }

extension NumberTriviaStatusX on NumberTriviaStatus {
  bool get isInitial => this == NumberTriviaStatus.initial;
  bool get isLoading => this == NumberTriviaStatus.loading;
  bool get isSuccess => this == NumberTriviaStatus.success;
  bool get isFailure => this == NumberTriviaStatus.failure;
}

class NumberTriviaState extends Equatable {
  final NumberTriviaStatus status;
  final NumberTrivia? trivia;
  final List<NumberTrivia>? triviaRecords;
  final String? failureMessage;

  const NumberTriviaState({
    this.status = NumberTriviaStatus.initial,
    this.trivia,
    this.triviaRecords,
    this.failureMessage,
  });

  NumberTriviaState copyWith({
    NumberTriviaStatus? status,
    NumberTrivia? trivia,
    List<NumberTrivia>? triviaRecords,
    String? failureMessage,
  }) {
    return NumberTriviaState(
      status: status ?? this.status,
      trivia: trivia ?? this.trivia,
      triviaRecords: triviaRecords ?? this.triviaRecords,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [status, trivia, triviaRecords, failureMessage];
}
