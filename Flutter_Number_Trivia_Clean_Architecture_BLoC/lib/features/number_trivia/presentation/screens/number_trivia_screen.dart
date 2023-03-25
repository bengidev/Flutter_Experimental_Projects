import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/widgets/widgets_barrel.dart';
import 'package:sized_context/sized_context.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NumberTriviaScreen extends HookWidget {
  static const routeName = '/numberTrivia';
  static const _numberTriviaKey = Key('numberTriviaKey');

  const NumberTriviaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberStringValue = useState(" ");

    return VisibilityDetector(
      key: NumberTriviaScreen._numberTriviaKey,
      onVisibilityChanged: (VisibilityInfo info) {
        final visiblePercentage = info.visibleFraction * 100;
        useLogger(
          object:
              "NumberTriviaPage Visibility -> ${info.key} is $visiblePercentage% visible",
        );
      },
      child: BlocProvider(
        create: (_) => $serviceLocator.get<NumberTriviaBloc>(),
        child: ScaffoldWithSafeArea(
          child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
            builder: (context, state) {
              return PaddedColumn(
                padding: EdgeInsets.all($styles.insets.sm),
                children: [
                  Expanded(
                    child: ExpandedScrollingColumn(
                      children: [
                        SizedBox(
                          width: context.widthPx,
                          height: context.heightPx * 0.45,
                          child: _checkReturnedResultNumberTriviaWidget(
                            context: context,
                            state: state,
                          ),
                        ),
                        Gap($styles.insets.sm),
                        SizedBox(
                          width: context.widthPx,
                          height: context.heightPx * 0.18,
                          child: BodyWidget(
                            onStringCallback: (string) =>
                                numberStringValue.value = string,
                          ),
                        ),
                        SizedBox(
                          width: context.widthPx,
                          height: context.heightPx * 0.14,
                          child: FooterWidget(
                            onSearchCallback: () {
                              _dispatchConcreteEvent(
                                context: context,
                                numberString: numberStringValue.value,
                              );
                              _dispatchCollectRecordsEvent(context: context);
                            },
                            onRandomCallback: () {
                              _dispatchRandomEvent(context: context);
                              _dispatchCollectRecordsEvent(context: context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _checkReturnedResultNumberTriviaWidget({
    required BuildContext context,
    required NumberTriviaState state,
  }) {
    switch (state.status) {
      case NumberTriviaStatus.initial:
        return const HeaderWidget(
          imageString: ConstantAssets.videoParkImage,
          message: "Let's search the meaning of your favorite numbers",
        );
      case NumberTriviaStatus.loading:
        return const AppLoadingIndicator();
      case NumberTriviaStatus.success:
        return HeaderWidget(
          imageString: ConstantAssets.dogCallImage,
          message: "The number of ${state.trivia?.number} mean is "
              "${state.trivia?.text}",
        );
      case NumberTriviaStatus.failure:
        return HeaderWidget(
          imageString: ConstantAssets.callWaitingImage,
          message: state.failureMessage,
        );
    }
  }

  void _dispatchConcreteEvent({
    required BuildContext context,
    required String? numberString,
  }) {
    context.read<NumberTriviaBloc>().add(
          GetTriviaForConcreteNumberEvent(numberString: numberString ?? " "),
        );
  }

  void _dispatchRandomEvent({required BuildContext context}) {
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumberEvent());
  }

  void _dispatchCollectRecordsEvent({required BuildContext context}) {
    context.read<NumberTriviaBloc>().add(CollectNumberTriviaRecordsEvent());
  }
}
