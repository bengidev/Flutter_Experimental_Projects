import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/generated/assets.dart';
import 'package:gap/gap.dart';

class OnboardingLogo extends HookWidget {
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
        Gap($appStyles.insets.md),
        StaticTextScale(
          child: Text(
            "Weather Sense",
            style: $appStyles.textStyle.wonderTitle.copyWith(
              fontSize: 32 * $appStyles.scale,
            ),
          ),
        ),
      ],
    );
  }
}
