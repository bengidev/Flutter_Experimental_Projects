import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/home_barrel.dart';

class DetailFeaturedTrivia extends HookWidget {
  static const routeName = '/detailFeaturedTrivia';
  final String? number;
  final String? triviaDescription;

  const DetailFeaturedTrivia({
    super.key,
    required this.number,
    required this.triviaDescription,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithSafeArea(
      appBar: AppBar(),
      child: Column(
        children: [
          const DetailFeaturedHeader(),
          Gap($styles.insets.xs),
          DetailFeaturedCard(
            number: number,
            triviaDescription: triviaDescription,
          ),
        ],
      ),
    );
  }
}
