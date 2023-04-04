import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StaticTextScale extends HookWidget {
  final Widget child;
  final double scale;

  const StaticTextScale({
    super.key,
    required this.child,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
      child: child,
    );
  }
}
