import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflix/core/core_barrel.dart';
import 'package:newsflix/features/intro/views/intro_view.dart';

class AppGoRouter {
  static GoRouter builder = _buildRouter();
  static const String introPath = '/intro';

  /// [GlobalKey] for identify its Navigator Widget when needed.
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// [GlobalKey] for identify its Shell Widget when needed.
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  /// Build [GoRouter] settings such as [initialLocation], [routes], [redirect], etc.
  static GoRouter _buildRouter() {
    final appRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: AppGoRouter.introPath,
      routes: [
        AppRoute(
          parentNavigatorKey: _rootNavigatorKey,
          name: AppGoRouter.introPath,
          path: AppGoRouter.introPath,
          builder: (_, __) => const IntroView(),
          useFade: true,
        ),
      ],
    );

    return appRouter;
  }
}
