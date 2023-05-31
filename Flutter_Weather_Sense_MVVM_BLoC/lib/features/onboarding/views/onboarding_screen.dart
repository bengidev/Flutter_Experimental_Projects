import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_views_barrel.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingScreen extends HookWidget {
  static const _imageSize = 250.0;
  static const _logoHeight = 125.0;
  static const _dataExamples = OnboardingData.examples;

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
                  Gap($styles.insets.sm),
                  Container(
                    alignment: Alignment.center,
                    height: _logoHeight,
                    child: const OnboardingLogo(),
                  ),

                  // Image and Masked Image
                  Gap($styles.insets.sm),
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
                  Gap(context.heightPct(0.2)),
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
              const OnboardingHorizontalGradientOverlay(isLeft: true),
              const OnboardingHorizontalGradientOverlay(),

              // Finish Button
              Positioned(
                right: $styles.insets.lg,
                bottom: context.heightPct(0.03),
                child: OnboardingFinishButton(
                  context: context,
                  valueListenable: currentPage,
                  data: _dataExamples,
                  onPressed: () async {
                    await _handleIntroCompletePressed(
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
                  child: OnboardingNavigationText(
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

  Future<void> _handleIntroCompletePressed({
    required BuildContext context,
    required PageController pageController,
  }) async {
    final permissionResults = await _requestDeviceFunctionalityPermissions();
    debugPrint("Permission Results -> $permissionResults");

    if (context.mounted) {
      await _saveOnboardingState(
        context: context,
        pageController: pageController,
      );
    }
  }

  Future<Map<Permission, PermissionStatus>>
      _requestDeviceFunctionalityPermissions() async {
    return PermissionsHandleHelper.requestPermissions(
      permissions: [
        Permission.location,
      ],
    );
  }

  Future<void> _saveOnboardingState({
    required BuildContext context,
    required PageController pageController,
  }) async {
    final current = pageController.page?.round() ?? 0;

    if (current == _dataExamples.length - 1) {
      final hasOperationCompleted =
          await SharedPreferencesStorage.setHasOnboardingCompleted(
        wasCompleted: true,
      );

      if (hasOperationCompleted && context.mounted) {
        debugPrint("Intro Complete Pressed with saved onboarding state");

        _navigateToAppNavigation(context: context);
      }
    }
  }

  void _navigateToAppNavigation({
    required BuildContext context,
  }) {
    context.goNamed(AppGoRouter.appNavigationPath);
  }
}
