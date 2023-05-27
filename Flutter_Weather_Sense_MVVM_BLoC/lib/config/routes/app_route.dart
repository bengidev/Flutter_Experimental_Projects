import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom GoRoute sub-class to make the router declaration easier to read
class AppRoute extends GoRoute {
  final bool useFade;
  final bool resizeToAvoidBottomInset;

  AppRoute({
    required super.parentNavigatorKey,
    super.name,
    required super.path,
    required super.builder,
    super.redirect,
    super.routes = const [],
    this.useFade = false,
    this.resizeToAvoidBottomInset = false,
  }) : super(
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder!(context, state),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            );

            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }

            return MaterialPage(child: pageContent);
          },
        );
}
