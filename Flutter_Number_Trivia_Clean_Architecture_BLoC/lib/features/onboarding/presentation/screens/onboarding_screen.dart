import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/core/widgets/app_navigation_bar.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/onboarding/presentation/widgets/onboarding_widgets_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingScreen extends HookWidget {
  static const routeName = '/onboarding';
  static const onboardingValue = 'ONBOARDING_VALUE_KEY';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithSafeArea(
      backgroundColor: $styles.colors.offWhite,
      child: Column(
        children: [
          Gap($styles.insets.lg),
          const OnboardingHeaderWidget(),
          Gap($styles.insets.xl),
          const OnboardingBodyWidget(),
          Gap(context.heightPx * 0.09),
          OnboardingFooterWidget(
            onPressed: () async {
              await _setOnboardingValueIntoSharedPreferences(hasShown: true);

              if (context.mounted) {
                _navigateIntoAppNavigationBar(context: context);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _setOnboardingValueIntoSharedPreferences({
    required bool hasShown,
  }) {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final operationResult =
        sharedPreferences.setBool(OnboardingScreen.onboardingValue, true);
    return operationResult;
  }

  void _navigateIntoAppNavigationBar({
    required BuildContext context,
  }) {
    Navigator.of(context).pushReplacementNamed(AppNavigationBar.routeName);
  }
}
