import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/dependency_injections/dependency_injection.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/widgets/gradient_container.dart';

class OnboardingHorizontalGradientOverlay extends StatelessWidget {
  final bool isLeft;

  const OnboardingHorizontalGradientOverlay({
    super.key,
    this.isLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(isLeft ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Padding(
          padding: EdgeInsets.only(
            left: isLeft ? 0 : 200,
            right: isLeft ? 200 : 0,
          ),
          child: Transform.scale(
            scaleX: isLeft ? -1 : 1,
            child: HorizontalGradientContainer(
              colors: [
                $styles.colors.tertiary.withOpacity(0),
                $styles.colors.tertiary,
              ],
              stops: const [0, 0.2],
            ),
          ),
        ),
      ),
    );
  }
}
