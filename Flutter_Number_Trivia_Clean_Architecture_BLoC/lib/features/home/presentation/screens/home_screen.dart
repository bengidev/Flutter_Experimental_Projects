import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/detail_featured_trivia.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/home_barrel.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends HookWidget {
  static const routeName = '/home';
  static const _homeKey = Key('homeKey');

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => $serviceLocator<RandomGeneratedTriviaBloc>(),
      child: BlocBuilder<RandomGeneratedTriviaBloc, RandomGeneratedTriviaState>(
        builder: (context, state) {
          return VisibilityDetector(
            key: HomeScreen._homeKey,
            onVisibilityChanged: (VisibilityInfo info) {
              final visiblePercentage = info.visibleFraction * 100;
              if (visiblePercentage != 100) return;

              // Call function for process something when this page was loaded
              context
                  .read<RandomGeneratedTriviaBloc>()
                  .add(const GetRandomGeneratedTriviaEvent());
            },
            child: ScaffoldWithSafeArea(
              child: Column(
                children: [
                  const AppTitle(),
                  Gap($styles.insets.sm),
                  const HomeHeader(),
                  Gap($styles.insets.xs),
                  HomeFeaturedTrivia(
                    onPressed: (state.status.isSuccess)
                        ? () {
                            Navigator.of(context).pushNamed(
                              DetailFeaturedTrivia.routeName,
                              arguments: {
                                'number': state.trivia?.number,
                                'triviaDescription': state.trivia?.text,
                              },
                            );
                          }
                        : null,
                    number: _extractHomeFeaturedTriviaResult(state: state) ??
                        "Please Wait...",
                  ),
                  Gap($styles.insets.xs),
                  const Expanded(
                    child: HomeSearchHistory(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToDetailFeaturedTrivia({
    required BuildContext context,
    required RandomGeneratedTriviaState state,
  }) {
    Navigator.of(context).pushNamed(
      DetailFeaturedTrivia.routeName,
      // arguments: <String, dynamic>{
      //   'number': state.trivia?.number.toString(),
      //   'triviaDescription': state.trivia?.text,
      // },
    );
  }

  String? _extractHomeFeaturedTriviaResult({
    required RandomGeneratedTriviaState state,
  }) {
    switch (state.status) {
      case RandomGeneratedTriviaStatus.initial:
        return "Please Wait...";
      case RandomGeneratedTriviaStatus.loading:
        return "Please Wait...";
      case RandomGeneratedTriviaStatus.success:
        return state.trivia?.number.toString();
      case RandomGeneratedTriviaStatus.failure:
        return state.failureMessage;
    }
  }
}
