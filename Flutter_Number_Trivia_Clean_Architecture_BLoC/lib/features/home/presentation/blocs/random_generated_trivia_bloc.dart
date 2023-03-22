import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/domain/entities/random_generated_trivia.dart';
import 'package:number_trivia_project/features/home/domain/usecases/get_random_generated_trivia_case.dart';

part 'random_generated_trivia_event.dart';
part 'random_generated_trivia_state.dart';

class RandomGeneratedTriviaBloc
    extends Bloc<RandomGeneratedTriviaEvent, RandomGeneratedTriviaState> {
  final GetRandomGeneratedTriviaCase _useCase;

  RandomGeneratedTriviaBloc({
    required GetRandomGeneratedTriviaCase useCase,
  })  : _useCase = useCase,
        super(const RandomGeneratedTriviaState()) {
    on<GetRandomGeneratedTriviaEvent>(_onGetRandomGeneratedTrivia);
  }

  Future<void> _onGetRandomGeneratedTrivia(
    GetRandomGeneratedTriviaEvent event,
    Emitter<RandomGeneratedTriviaState> emit,
  ) async {
    emit(state.copyWith(status: RandomGeneratedTriviaStatus.loading));
    final randomGeneratedTrivia = await _useCase.call(EmptyParams());
    randomGeneratedTrivia.fold(
      (failure) => emit(
        state.copyWith(
          status: RandomGeneratedTriviaStatus.failure,
          failureMessage: "${failure.runtimeType}",
        ),
      ),
      (trivia) => emit(
        state.copyWith(
          status: RandomGeneratedTriviaStatus.success,
          trivia: trivia,
        ),
      ),
    );
  }
}
