import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/usecases/usecase.dart';
import 'package:number_trivia_project/core/utilities/input_converter.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/collect_number_trivia_records_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_concrete_number_trivia_case.dart';
import 'package:number_trivia_project/features/number_trivia/domain/usecases/get_random_number_trivia_case.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  static const String serverFailureMessage = "Server Failure";
  static const String cacheFailureMessage = "Cache Failure";
  static const String invalidInputFailureMessage =
      "Invalid Input - The number must be positive integer or zero";

  final GetConcreteNumberTriviaCase getConcreteNumberTrivia;
  final GetRandomNumberTriviaCase getRandomNumberTrivia;
  final CollectNumberTriviaRecordsCase collectNumberTriviaRecordsCase;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTriviaCase concreteTrivia,
    required GetRandomNumberTriviaCase randomTrivia,
    required CollectNumberTriviaRecordsCase collectTriviaRecords,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concreteTrivia,
        getRandomNumberTrivia = randomTrivia,
        collectNumberTriviaRecordsCase = collectTriviaRecords,
        super(const NumberTriviaState()) {
    on<GetTriviaForConcreteNumberEvent>(_onGetTriviaForConcreteNumber);

    on<GetTriviaForRandomNumberEvent>(_onGetTriviaForRandomNumber);

    on<CollectNumberTriviaRecordsEvent>(_onCollectNumberTriviaRecords);
  }

  Future<void> _onGetTriviaForConcreteNumber(
    GetTriviaForConcreteNumberEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final inputEither = inputConverter.stringToUnsignedInteger(
      string: event.numberString,
    );
    inputEither.fold((failure) {
      emit(
        state.copyWith(
          status: NumberTriviaStatus.failure,
          failureMessage: NumberTriviaBloc.invalidInputFailureMessage,
        ),
      );
    }, (parsedNumber) async {
      emit(state.copyWith(status: NumberTriviaStatus.loading));
      final params = ConcreteParams(number: parsedNumber);
      final failureOrTrivia = await getConcreteNumberTrivia(params);
      _eitherFailureOrSuccessfulState(failureOrTrivia, emit);
    });
  }

  Future<void> _onGetTriviaForRandomNumber(
    GetTriviaForRandomNumberEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(state.copyWith(status: NumberTriviaStatus.loading));
    final params = EmptyParams();
    final failureOrTrivia = await getRandomNumberTrivia(params);
    _eitherFailureOrSuccessfulState(failureOrTrivia, emit);
  }

  Future<void> _onCollectNumberTriviaRecords(
    CollectNumberTriviaRecordsEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(state.copyWith(status: NumberTriviaStatus.loading));
    final params = EmptyParams();
    final failureOrTrivia = await collectNumberTriviaRecordsCase(params);
    _eitherFailureOrSuccessfulRecordsState(failureOrTrivia, emit);
  }

  Future<void> _eitherFailureOrSuccessfulState(
    Either<Failure, NumberTrivia> failureOrTrivia,
    Emitter<NumberTriviaState> emit,
  ) async {
    failureOrTrivia.fold((failure) {
      emit(
        state.copyWith(
          status: NumberTriviaStatus.failure,
          failureMessage: _convertFailureToMessage(failure: failure),
        ),
      );
    }, (trivia) {
      emit(
        state.copyWith(
          status: NumberTriviaStatus.success,
          trivia: trivia,
        ),
      );
    });
  }

  Future<void> _eitherFailureOrSuccessfulRecordsState(
    Either<Failure, List<NumberTrivia>> failureOrTrivia,
    Emitter<NumberTriviaState> emit,
  ) async {
    failureOrTrivia.fold((failure) {
      emit(
        state.copyWith(
          status: NumberTriviaStatus.failure,
          failureMessage: _convertFailureToMessage(failure: failure),
        ),
      );
    }, (triviaRecords) {
      emit(
        state.copyWith(
          status: NumberTriviaStatus.success,
          triviaRecords: triviaRecords,
        ),
      );
    });
  }

  String _convertFailureToMessage({required Failure failure}) {
    switch (failure.runtimeType) {
      case InvalidInputFailure:
        return NumberTriviaBloc.invalidInputFailureMessage;
      case ServerFailure:
        return NumberTriviaBloc.serverFailureMessage;
      case CacheFailure:
        return NumberTriviaBloc.cacheFailureMessage;
      default:
        return "Unexpected Error";
    }
  }
}
