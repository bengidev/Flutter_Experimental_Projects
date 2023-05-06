import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';

class OnboardingPNGExtensionStack extends StatelessWidget {
  const OnboardingPNGExtensionStack({
    super.key,
    required this.onboardingData,
  });

  final OnboardingData onboardingData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/${onboardingData.image}.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Image.asset(
            "assets/images/${onboardingData.image}.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
