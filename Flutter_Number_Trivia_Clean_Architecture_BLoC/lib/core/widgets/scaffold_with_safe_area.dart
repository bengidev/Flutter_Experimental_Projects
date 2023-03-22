import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScaffoldWithSafeArea extends HookWidget {
  final AppBar? appBar;
  final Widget? body;
  final Widget? child;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const ScaffoldWithSafeArea({
    Key? key,
    this.appBar,
    this.body,
    this.child,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: body ??
          SafeArea(
            child: child ??
                const Center(
                  child: Text("Empty Child Widget"),
                ),
          ),
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
