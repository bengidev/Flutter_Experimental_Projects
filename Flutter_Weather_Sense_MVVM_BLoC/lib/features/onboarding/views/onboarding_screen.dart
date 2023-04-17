import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/widgets/gradient_container.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_description.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_image.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_logo.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_context/sized_context.dart';

class OnboardingScreen extends HookWidget {
  static const _imageSize = 250.0;
  static const _logoHeight = 125.0;
  static const _dataExamples = OnboardingData.examples;
  static const onboardingCompletedKey = "ONBOARDING_COMPLETED_KEY";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useValueNotifier<int>(0);
    final pages = _dataExamples
        .map<Widget>(
          (data) => OnboardingDescription(
            key: ValueKey(data.title),
            data: data,
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: $styles.colors.tertiary,
      body: SafeArea(
        child: Animate(
          delay: const Duration(milliseconds: 500),
          effects: const [
            FadeEffect(),
          ],
          child: Stack(
            children: [
              // PageView with title and description
              PageView(
                controller: pageController,
                children: pages,
                onPageChanged: (value) {
                  currentPage.value = value;
                },
              ),
              Column(
                children: [
                  // Logo and Text Logo
                  const Gap(50),
                  Container(
                    alignment: Alignment.center,
                    height: _logoHeight,
                    child: const OnboardingLogo(),
                  ),

                  // Image and Masked Image
                  const Gap(30),
                  SizedBox(
                    width: _imageSize,
                    height: _imageSize,
                    child: ValueListenableBuilder<int>(
                      valueListenable: currentPage,
                      builder: (context, value, child) {
                        return AnimatedSwitcher(
                          duration: $styles.times.slow,
                          child: KeyedSubtree(
                            key: ValueKey(value),
                            child: OnboardingImage(
                              onboardingData: _dataExamples.elementAt(value),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Page Indicator
                  const Gap(130),
                  AppPageIndicator(
                    width: context.widthPx * 0.9,
                    height: context.heightPx * 0.03,
                    controller: pageController,
                    totalPages: _dataExamples.length,
                    onDotPressed: (index) {
                      debugPrint("onDotPressed index -> $index");
                      _handlePageIndicatorPressed(
                        pageController: pageController,
                        selectedIndicator: index,
                      );
                    },
                  ),
                ],
              ),

              //Build a couple overlays to hide the content when swiping on very wide screens
              _buildHorizontalGradientOverlay(left: true),
              _buildHorizontalGradientOverlay(),

              // Finish Button
              Positioned(
                right: $styles.insets.lg,
                bottom: 10,
                child: _buildFinishButton(
                  context: context,
                  valueListenable: currentPage,
                  data: _dataExamples,
                  onPressed: () {
                    _handleIntroCompletePressed(
                      context: context,
                      pageController: pageController,
                    );
                  },
                ),
              ),

              // Navigation Helper Text
              BottomCenter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: $styles.insets.lg),
                  child: _buildNavigationText(
                    context: context,
                    valueListenable: currentPage,
                    data: _dataExamples,
                    onPressed: () {
                      _handleNavigationTextPressed(
                        pageController: pageController,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalGradientOverlay({bool left = false}) {
    return Align(
      alignment: Alignment(left ? -1 : 1, 0),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Padding(
          padding: EdgeInsets.only(
            left: left ? 0 : 200,
            right: left ? 200 : 0,
          ),
          child: Transform.scale(
            scaleX: left ? -1 : 1,
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

  Widget _buildFinishButton({
    required BuildContext context,
    required ValueListenable<int> valueListenable,
    required List<OnboardingData> data,
    void Function()? onPressed,
  }) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == data.length - 1 ? 1 : 0,
          duration: $styles.times.fast,
          child: AppCircleButton(
            onPressed: onPressed ?? () {},
            child: const Icon(Icons.arrow_forward_rounded),
          ),
        );
      },
    );
  }

  Widget _buildNavigationText({
    required BuildContext context,
    required ValueListenable<int> valueListenable,
    required List<OnboardingData> data,
    void Function()? onPressed,
  }) {
    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (_, pageIndex, __) {
        return AnimatedOpacity(
          opacity: pageIndex == data.length - 1 ? 0 : 1,
          duration: $styles.times.fast,
          child: AppButton(
            backgroundColor: Colors.transparent,
            foregroundColor: $styles.colors.primary,
            onPressed: onPressed ?? () {},
            child: AppAutoResizeText(
              text: "Swipe left to continue",
              textAlign: TextAlign.center,
              textStyle: $styles.textStyle.bodySmall,
            ),
          ),
        );
      },
    );
  }

  void _handlePageIndicatorPressed({
    required PageController pageController,
    required int selectedIndicator,
  }) {
    pageController.animateToPage(
      selectedIndicator,
      duration: 250.ms,
      curve: Curves.easeIn,
    );
  }

  void _handleNavigationTextPressed({
    required PageController pageController,
  }) {
    final current = pageController.page?.round() ?? 0;

    if (_isOnLastPage(pageController: pageController)) return;
    pageController.animateToPage(
      current + 1,
      duration: 250.ms,
      curve: Curves.easeIn,
    );
  }

  bool _isOnLastPage({
    required PageController pageController,
  }) {
    if (pageController.page != null && _dataExamples.isNotEmpty) {
      return pageController.page == _dataExamples.length - 1;
    } else {
      return false;
    }
  }

  void _handleIntroCompletePressed({
    required BuildContext context,
    required PageController pageController,
  }) {
    final current = pageController.page?.round() ?? 0;

    if (current == _dataExamples.length - 1) {
      final sharedPreferences = $serviceLocator.get<SharedPreferences>();
      sharedPreferences.setBool(OnboardingScreen.onboardingCompletedKey, true);

      if (sharedPreferences
          .containsKey(OnboardingScreen.onboardingCompletedKey)) {
        debugPrint("Intro Complete Pressed");
        debugPrint(
          "Shared Preferences Status -> ${sharedPreferences.runtimeType}",
        );

        context.goNamed(AppRouter.appNavigationPath);
      }
    }
  }
}
