import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/widgets/app_auto_resize_text.dart';
import 'package:gap/gap.dart';
import 'package:sized_context/sized_context.dart';

@immutable
class OnboardingData extends Equatable {
  final String title;
  final String description;
  final String image;
  final String extensionType;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.image,
    required this.extensionType,
  });

  static const examples = <OnboardingData>[
    OnboardingData(
      title: "Your Personalized Weather Forecast",
      description:
          "Set your preferences and get a customized weather forecast that's tailored to your needs.",
      image: 'weather_pana',
      extensionType: '.svg',
    ),
    OnboardingData(
      title: "Plan Ahead with Hourly Forecasts",
      description:
          "Plan your day with hourly weather forecasts that help you stay ahead of changing weather conditions.",
      image: 'umbrella_pana',
      extensionType: '.svg',
    ),
    OnboardingData(
      title: "Stay Safe with Severe Weather Alerts",
      description:
          "Get notified of severe weather events in your area so you can stay safe and prepared.",
      image: 'season_change_pana',
      extensionType: '.svg',
    ),
  ];

  @override
  List<Object?> get props => [title, description, image];
}

class OnboardingDescription extends HookWidget {
  final OnboardingData data;

  const OnboardingDescription({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: $appStyles.insets.md,
      ),
      child: Column(
        children: [
          const Spacer(),
          const Gap(370),
          SizedBox(
            width: context.widthPx * 0.9,
            height: context.heightPx * 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppAutoResizeText(
                  width: context.widthPx * 0.9,
                  text: data.title,
                  textStyle: $appStyles.textStyle.wonderTitle.copyWith(
                    fontSize: 24 * $appStyles.scale,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                Gap($appStyles.insets.sm),
                AppAutoResizeText(
                  width: context.widthPx * 0.9,
                  height: context.heightPx * 0.07,
                  text: data.description,
                  textStyle: $appStyles.textStyle.body5,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          const Gap(40),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
