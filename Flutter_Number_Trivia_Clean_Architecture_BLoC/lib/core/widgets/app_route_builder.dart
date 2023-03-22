import 'package:flutter/material.dart';

class AppRouteBuilder {
  static PageRouteBuilder buildWithSlideTransition({
    required RouteSettings settings,
    required BuildContext context,
    required Widget Function() child,
    bool? fullScreenDialog,
  }) {
    return PageRouteBuilder(
      fullscreenDialog: fullScreenDialog ?? false,
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => child.call(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
