import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/widgets/number_trivia_widgets_barrel.dart';
import 'package:sized_context/sized_context.dart';

class ReturnedResultNumberTriviaWidget extends HookWidget {
  const ReturnedResultNumberTriviaWidget({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final NumberTriviaState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.widthPx,
      height: context.heightPx * 0.45,
      child: _checkReturnedResultNumberTrivia(state: state),
    );
  }

  Widget _checkReturnedResultNumberTrivia({
    required NumberTriviaState state,
  }) {
    switch (state.status) {
      case NumberTriviaStatus.initial:
        return const NumberTriviaHeaderWidget(
          imageString: ConstantAssets.videoParkImage,
          message: "Let's search the meaning of your favorite numbers",
        );
      case NumberTriviaStatus.loading:
        return const AppLoadingIndicator();
      case NumberTriviaStatus.success:
        return NumberTriviaHeaderWidget(
          imageString: ConstantAssets.dogCallImage,
          message: "The number of ${state.trivia?.number} mean is "
              "${state.trivia?.text}",
        );
      case NumberTriviaStatus.failure:
        return NumberTriviaHeaderWidget(
          imageString: ConstantAssets.callWaitingImage,
          message: state.failureMessage,
        );
    }
  }
}
