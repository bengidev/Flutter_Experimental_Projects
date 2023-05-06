import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class HomeEarlyWarningDescription extends StatelessWidget {
  const HomeEarlyWarningDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: $styles.insets.sm,
        right: $styles.insets.sm,
      ),
      child: Column(
        children: [
          AppAutoResizeText(
            width: context.widthPx,
            alignment: Alignment.centerLeft,
            text: "Early Warning",
            textStyle: $styles.textStyle.h5Bold,
            maxLines: 1,
          ),
          AppAutoResizeText(
            width: context.widthPx,
            alignment: Alignment.centerLeft,
            text: "See the National Weather Service alerts around you",
            textStyle: $styles.textStyle.body5,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
