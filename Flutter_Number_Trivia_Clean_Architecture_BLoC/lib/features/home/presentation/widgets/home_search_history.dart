import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/home_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:sized_context/sized_context.dart';

class HomeSearchHistory extends HookWidget {
  final List<NumberTrivia>? triviaRecords;

  const HomeSearchHistory({
    super.key,
    this.triviaRecords,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.widthPx,
          height: context.heightPx * 0.05,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: $styles.insets.sm),
          child: AppText(
            text: ConstantTexts.yourSearchHistory,
            textAlign: TextAlign.center,
            textStyle: $styles.textStyle.title1Bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: triviaRecords?.length,
            itemBuilder: (context, index) {
              return SearchHistoryItem(
                number: triviaRecords?.elementAt(index).number.toString(),
                description: triviaRecords?.elementAt(index).text,
                onTap: () {
                  return _navigateToDetailFeaturedTrivia(
                    context: context,
                    triviaRecords: triviaRecords,
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Future<Object?> _navigateToDetailFeaturedTrivia({
    required BuildContext context,
    required List<NumberTrivia>? triviaRecords,
    required int index,
  }) {
    return Navigator.of(context).pushNamed(
      DetailFeaturedTrivia.routeName,
      arguments: {
        'number': triviaRecords?.elementAt(index).number.toString(),
        'triviaDescription': triviaRecords?.elementAt(index).text,
      },
    );
  }
}
