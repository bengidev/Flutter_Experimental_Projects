import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/dependency_injections/dependency_injection.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';

class OnboardingFinishButton extends StatelessWidget {
  final BuildContext context;
  final ValueListenable<int> valueListenable;
  final List<OnboardingData> data;
  final Function()? onPressed;

  const OnboardingFinishButton({
    required this.context,
    required this.valueListenable,
    required this.data,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == data.length - 1 ? 1 : 0,
          duration: $styles.times.fast,
          child: AppCircleButton(
            onPressed: onPressed,
            child: const Icon(Icons.arrow_forward_rounded),
          ),
        );
      },
    );
  }
}
