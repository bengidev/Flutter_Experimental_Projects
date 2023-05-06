import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';

class OnboardingSVGExtensionStack extends StatelessWidget {
  const OnboardingSVGExtensionStack({
    super.key,
    required this.onboardingData,
  });

  final OnboardingData onboardingData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: SvgPicture.asset(
            "assets/images/${onboardingData.image}.svg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            "assets/images/${onboardingData.image}.svg",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
