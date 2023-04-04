import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';

class OnboardingImage extends HookWidget {
  final OnboardingData onboardingData;

  const OnboardingImage({
    super.key,
    required this.onboardingData,
  });

  @override
  Widget build(BuildContext context) {
    return onboardingData.extensionType.contains('.png')
        ? _buildPNGExtensionStack()
        : _buildSVGExtensionStack();
  }

  Widget _buildPNGExtensionStack() {
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

  Widget _buildSVGExtensionStack() {
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
