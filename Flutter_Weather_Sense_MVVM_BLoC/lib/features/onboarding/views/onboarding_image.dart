import 'package:flutter/widgets.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_png_extension_stack.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_svg_extension_stack.dart';

class OnboardingImage extends StatelessWidget {
  final OnboardingData onboardingData;

  const OnboardingImage({
    super.key,
    required this.onboardingData,
  });

  @override
  Widget build(BuildContext context) {
    return onboardingData.extensionType.contains('.png')
        ? OnboardingPNGExtensionStack(onboardingData: onboardingData)
        : OnboardingSVGExtensionStack(onboardingData: onboardingData);
  }
}
