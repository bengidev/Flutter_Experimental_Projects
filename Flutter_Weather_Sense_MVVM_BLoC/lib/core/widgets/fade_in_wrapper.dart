import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FadeInWrapper extends HookWidget {
  final Widget child;
  const FadeInWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Create an AnimationController. The controller will automatically be
    // disposed when the widget is unmounted.
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 250),
    );

    // useEffect is the equivalent of initState + didUpdateWidget + dispose.
    // The callback passed to useEffect is executed the first time the hook is
    // invoked, and then whenever the list passed as second parameter changes.
    // Since we pass an empty const list here, that's strictly equivalent to `initState`.
    useEffect(
      () {
        // start the animation when the widget is first rendered.
        animationController.forward();
        // We could optionally return some "dispose" logic here
        return null;
      },
      [animationController],
    );

    // Tell Flutter to rebuild this widget when the animation updates.
    // This is equivalent to AnimatedBuilder
    useAnimation(animationController);

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animationController),
      child: child,
    );
  }
}
