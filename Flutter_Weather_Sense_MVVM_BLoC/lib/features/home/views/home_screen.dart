import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_early_warning_cards.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_early_warning_description.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_greeting_description.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_location_map.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_weather_card.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            const HomeGreetingDescription(),
            Gap($styles.insets.md),

            // Header Section
            AppRawAutoCompleteField(
              key: const ValueKey('FIRST_APP_TEXT_FORM_FIELD'),
              objects: const <String>[
                "Object String 1",
                "Object String 2",
                "Object String 3",
              ],
              onResult: (resultText) {
                if (resultText == null) return;
                debugPrint("Result Text -> $resultText");
              },
            ),
            Gap($styles.insets.sm),

            // Body Section
            const HomeLocationMap(),
            Gap($styles.insets.sm),

            // Body Section
            const HomeWeatherCard(),
            Gap($styles.insets.lg),

            // Body Section
            const HomeEarlyWarningDescription(),
            Gap($styles.insets.sm),

            // Footer Section
            const HomeEarlyWarningCards(),
          ],
        ),
      ),
    );
  }
}
