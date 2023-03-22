import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_project/core/errors/failure.dart';
import 'package:number_trivia_project/core/usecases/usecase.dart';
import 'package:number_trivia_project/core/utilities/input_converter.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
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
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required GetConcreteNumberTriviaCase concreteTrivia,
    required GetRandomNumberTriviaCase randomTrivia,
    required this.inputConverter,
  })  : getConcreteNumberTrivia = concreteTrivia,
        getRandomNumberTrivia = randomTrivia,
        super(NumberTriviaEmptyState()) {
    on<GetTriviaForConcreteNumberEvent>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInteger(
        str: event.numberString,
      );
      await inputEither.fold((failure) async {
        emit(const NumberTriviaErrorState(
            message: NumberTriviaBloc.invalidInputFailureMessage));
      }, (parsedNumber) async {
        emit(NumberTriviaLoadingState());
        final params = ConcreteParams(number: parsedNumber);
        final failureOrTrivia = await getConcreteNumberTrivia.call(params);
        _eitherFailureOrSuccessfulState(failureOrTrivia, emit);
      });
    });

    on<GetTriviaForRandomNumberEvent>(
      (event, emit) async {
        emit(NumberTriviaLoadingState());
        final params = EmptyParams();
        final failureOrTrivia = await getRandomNumberTrivia.call(params);
        _eitherFailureOrSuccessfulState(failureOrTrivia, emit);
      },
    );
  }

  Future<void> _eitherFailureOrSuccessfulState(
    Either<Failure, NumberTrivia> failureOrTrivia,
    Emitter<NumberTriviaState> emit,
  ) async {
    failureOrTrivia.fold((failure) {
      emit(NumberTriviaErrorState(
          message: _convertFailureToMessage(failure: failure)));
    }, (trivia) {
      emit(NumberTriviaLoadedState(trivia: trivia));
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
