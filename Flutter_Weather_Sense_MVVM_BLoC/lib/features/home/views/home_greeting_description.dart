import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class HomeGreetingDescription extends StatelessWidget {
  /// Text to be placed inside header section in [HomeGreetingDescription].
  final String? greetingMessage;

  /// Text to be placed below [greetingMessage]
  /// to show the initial weather status
  /// inside header section in [HomeGreetingDescription].
  final String? greetingStatus;

  const HomeGreetingDescription({
    super.key,
    this.greetingMessage,
    this.greetingStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all($styles.insets.sm),
      child: Column(
        children: [
          AppAutoResizeText(
            alignment: Alignment.centerLeft,
            text: greetingMessage ?? "Good Morning, ",
            textAlign: TextAlign.left,
            textStyle: $styles.textStyle.h3Bold,
            maxLines: 1,
          ),
          AppAutoResizeText(
            alignment: Alignment.centerLeft,
            text: greetingStatus ?? "Let's find out your weather conditions.",
            textAlign: TextAlign.left,
            textStyle: $styles.textStyle.body2,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
