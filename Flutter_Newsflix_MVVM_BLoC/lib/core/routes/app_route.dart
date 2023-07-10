import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom GoRoute sub-class to make the router declaration easier to read/
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
          // Build screen page with wrapping its content inside Scaffold.
          // If resizeToAvoidBottomInset was true, then the content
          // should size themselves to avoid the onscreen keyboard.
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder?.call(context, state),
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            );

            // If useFade was true, then it will wrap its screen page content
            // with [FadeTransition] effect.
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

            // Return screen page based on its [Platform] type.
            return Platform.isAndroid
                ? MaterialPage(child: pageContent)
                : CupertinoPage(child: pageContent);
          },
        );
}
