import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/widgets/number_trivia_widgets_barrel.dart';
import 'package:sized_context/sized_context.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NumberTriviaScreen extends HookWidget {
  static const routeName = '/numberTrivia';
  static const _numberTriviaKey = Key('numberTriviaKey');

  const NumberTriviaScreen({super.key});

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
                          child: ReturnedResultNumberTriviaWidget(
                            context: context,
                            state: state,
                          ),
                        ),
                        Gap($styles.insets.sm),
                        NumberTriviaBodyWidget(
                          onStringCallback: (string) =>
                              numberStringValue.value = string,
                        ),
                        NumberTriviaFooterWidget(
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
