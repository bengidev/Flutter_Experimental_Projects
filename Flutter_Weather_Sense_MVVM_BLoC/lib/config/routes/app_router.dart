import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_screen.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_screen.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/search_weather/views/search_weather_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static const String appNavigationPath = '/appNavigation';
  static const String onboardingPath = '/onboarding';
  static const String homePath = '/home';
  static const String searchWeatherPath = '/searchWeather';
  static GoRouter routerInstance = _buildAppRouter();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  /// The instance builder for initializing [GoRouter]'s settings
  /// such as [initialLocation], [routes], [redirect], etc.
  static GoRouter _buildAppRouter() {
    final appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: _hasOnboardingCompleted()
          ? AppRouter.appNavigationPath
          : AppRouter.onboardingPath,
      redirect: (context, state) => _handleRedirect(state: state),
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppRouter.appNavigationPath,
          path: AppRouter.appNavigationPath,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: AppNavigationScreen(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppRouter.onboardingPath,
          path: AppRouter.onboardingPath,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: OnboardingScreen(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppRouter.homePath,
          path: AppRouter.homePath,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: HomeScreen(),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppRouter.searchWeatherPath,
          path: AppRouter.searchWeatherPath,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: SearchWeatherScreen(),
            );
          },
        ),
      ],
    );

    return appRouter;
  }

  /// Decide the [initialLocation] section of [GoRouter] with conditional statements.
  static bool _hasOnboardingCompleted() {
    final sharedPreferences = $serviceLocator.get<SharedPreferences>();
    final hasCompletedOnboarding =
        sharedPreferences.getBool(OnboardingScreen.onboardingCompletedKey);

    if (hasCompletedOnboarding == null) return false;

    if (hasCompletedOnboarding) {
      return true;
    } else {
      return false;
    }
  }

  /// Handling the redirect section of [GoRouter] with additional requirement.
  /// Prevent anyone from navigating away from `/` or
  /// [initialLocation] if app is starting up.
  static Future<String?> _handleRedirect({
    required GoRouterState state,
  }) async {
    final sharedPreferences =
        await $serviceLocator.getAsync<SharedPreferences>();
    final hasCompletedOnboarding =
        sharedPreferences.getBool(OnboardingScreen.onboardingCompletedKey);

    if (hasCompletedOnboarding == null) return null;

    if (!hasCompletedOnboarding && state.location != AppRouter.onboardingPath) {
      return AppRouter.onboardingPath;
    }

    debugPrint('Navigate to: ${state.location}');
    return null;
  }
}
