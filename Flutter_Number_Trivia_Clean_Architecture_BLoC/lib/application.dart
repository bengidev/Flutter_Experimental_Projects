// coverage:ignore-file

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/core/widgets/app_navigation_bar.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/screens/home_screen.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/detail_featured_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/screens/number_trivia_screen.dart';
import 'package:number_trivia_project/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:number_trivia_project/features/profile/presentation/screens/profile_screen.dart';
import 'package:sized_context/sized_context.dart';

class Application extends HookWidget {
  // Static AppStyles configurations which used across all the widgets inside the Application.
  static AppStyles _style = AppStyles();

  static AppStyles get style => _style;

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // To determine if opacity blends are being optimized or not.
      // checkerboardRasterCacheImages: true,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) => _materialAppBuilderWidget(context, child),
      title: "Flutter Number Trivia",
      theme: ThemeData.from(colorScheme: $styles.colors.flexSchemeLight),
      darkTheme: ThemeData.from(colorScheme: $styles.colors.flexSchemeDark),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      initialRoute: AppNavigationBar.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppNavigationBar.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const AppNavigationBar(),
            );
          case OnboardingScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const OnboardingScreen(),
            );
          case HomeScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const HomeScreen(),
            );
          case DetailFeaturedTrivia.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              fullScreenDialog: true,
              settings: settings,
              context: context,
              child: () {
                final args = settings.arguments as Map<String, dynamic>?;
                return DetailFeaturedTrivia(
                  number: args?['number'].toString(),
                  triviaDescription: args?['triviaDescription'].toString(),
                );
              },
            );
          case NumberTriviaScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const NumberTriviaScreen(),
            );
          case ProfileScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const ProfileScreen(),
            );
        }
        return null;
      },
      onUnknownRoute: (settings) => _unknownRouteScreen(settings),
    );
  }

  Widget _materialAppBuilderWidget(BuildContext context, Widget? child) {
    // Listen to the device size, and update AppStyle when it changes.
    _style = AppStyles(
      screenSize: context.sizePx,
    );

    return DevicePreview.appBuilder(context, child);
  }

  MaterialPageRoute<void> _unknownRouteScreen(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: const EmptyPlaceholder(
          message: "404 - Page Not Found!",
        ),
      ),
    );
  }
}
