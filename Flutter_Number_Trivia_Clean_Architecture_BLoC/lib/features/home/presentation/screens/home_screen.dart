import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/blocs/random_generated_trivia_bloc.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/home_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends HookWidget {
  static const routeName = '/home';
  static const _homeKey = Key('homeKey');

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<NumberTrivia>>? futureTriviaRecords;

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

              final sharedPreferences = $serviceLocator<SharedPreferences>();
              futureTriviaRecords = _loadNumberTriviaRecords(
                sharedPreferences: sharedPreferences,
              );
              useLogger(
                object: "Trivia Records Value: $futureTriviaRecords",
              );
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
                            _navigateToDetailFeaturedTrivia(
                              context: context,
                              state: state,
                            );
                          }
                        : null,
                    number: _extractHomeFeaturedTriviaResult(state: state) ??
                        "Please Wait...",
                  ),
                  Gap($styles.insets.xs),
                  FutureBuilder<List<NumberTrivia>>(
                    future: futureTriviaRecords,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: HomeSearchHistory(
                            triviaRecords: snapshot.data,
                          ),
                        );
                      } else {
                        return const EmptySearchHistory();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<NumberTrivia>> _loadNumberTriviaRecords({
    required SharedPreferences sharedPreferences,
  }) {
    var triviaRecords = <NumberTrivia>[];

    if (sharedPreferences.containsKey("NUMBER_TRIVIA_STORE_CODE")) {
      final sharedPreferencesValue =
          sharedPreferences.getString("NUMBER_TRIVIA_STORE_CODE");
      if (sharedPreferencesValue != null) {
        triviaRecords = NumberTriviaModel.decodeToList(sharedPreferencesValue);
      }
    }

    return Future.delayed(
      const Duration(seconds: 1),
      () => Future<List<NumberTrivia>>.value(triviaRecords),
    );
  }

  void _navigateToDetailFeaturedTrivia({
    required BuildContext context,
    required RandomGeneratedTriviaState state,
  }) {
    Navigator.of(context).pushNamed(
      DetailFeaturedTrivia.routeName,
      arguments: {
        'number': state.trivia?.number,
        'triviaDescription': state.trivia?.text,
      },
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
