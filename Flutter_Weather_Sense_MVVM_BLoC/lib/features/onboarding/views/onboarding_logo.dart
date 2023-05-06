import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/generated/assets.dart';

class OnboardingLogo extends StatelessWidget {
  const OnboardingLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.imagesPlanetEarth,
          height: 50,
        ),
        Gap($styles.insets.md),
        StaticTextScale(
          child: Text(
            "Weather Sense",
            style: $styles.textStyle.wonderTitle.copyWith(
              fontSize: 32 * $styles.scale,
            ),
          ),
        ),
      ],
    );
  }
}
