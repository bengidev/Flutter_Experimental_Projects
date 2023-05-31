import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/dependency_injections/dependency_injection.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:sized_context/sized_context.dart';

class DailyHeader extends StatelessWidget {
  const DailyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAutoResizeText(
      width: context.widthPx,
      height: context.heightPct(0.07),
      alignment: Alignment.center,
      text: "7 Days Forecast",
      textStyle: $styles.textStyle.title1Bold,
      minFontSize: 20,
    );
  }
}
