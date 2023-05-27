import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/views/daily_weather_forecast_screen.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_screen.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

class AppGoRouter {
  static const String appNavigationPath = '/appNavigation';
  static const String onboardingPath = '/onboarding';
  static const String homePath = '/home';
  static const String dailyWeatherForecastPath = '/dailyWeatherForecast';
  static GoRouter routerInstance = _buildAppGoRouter();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  /// The instance builder for initializing [GoRouter]'s settings
  /// such as [initialLocation], [routes], [redirect], etc.
  static GoRouter _buildAppGoRouter() {
    final appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: _hasOnboardingCompleted()
          ? AppGoRouter.appNavigationPath
          : AppGoRouter.onboardingPath,
      redirect: (context, state) => _handleRedirect(state: state),
      routes: [
        AppRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppGoRouter.appNavigationPath,
          path: AppGoRouter.appNavigationPath,
          builder: (_, __) => const AppNavigationScreen(),
          useFade: true,
        ),
        AppRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppGoRouter.onboardingPath,
          path: AppGoRouter.onboardingPath,
          builder: (_, __) => const OnboardingScreen(),
          useFade: true,
        ),
        AppRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppGoRouter.homePath,
          path: AppGoRouter.homePath,
          builder: (_, __) => const HomeScreen(),
          useFade: true,
        ),
        AppRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppGoRouter.dailyWeatherForecastPath,
          path: AppGoRouter.dailyWeatherForecastPath,
          builder: (_, __) => const DailyWeatherForecastScreen(),
          useFade: true,
        ),
      ],
    );

    return appRouter;
  }

  /// Decide the [initialLocation] section of [GoRouter] with conditional statements.
  static bool _hasOnboardingCompleted() {
    return SharedPreferencesStorage.getHasOnboardingCompleted();
  }

  /// Handling the redirect section of [GoRouter] with additional requirement.
  /// Prevent anyone from navigating away from `/` or
  /// [initialLocation] if app is starting up.
  static Future<String?> _handleRedirect({
    required GoRouterState state,
  }) async {
    final hasCompletedOnboarding =
        SharedPreferencesStorage.getHasOnboardingCompleted();

    if (!hasCompletedOnboarding &&
        state.location != AppGoRouter.onboardingPath) {
      return AppGoRouter.onboardingPath;
    }

    debugPrint('Navigate to: ${state.location}');
    return null;
  }
}
