import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';

class AppButton extends HookWidget {
  final bool enableFeedback;
  final WidgetBuilder? builder;
  final EdgeInsets? padding;
  final bool expand;
  final bool circular;
  final Size? minimumSize;
  final BorderSide? borderSide;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;
  final bool pressEffect;
  final void Function()? onPressed;

  const AppButton({
    super.key,
    this.enableFeedback = true,
    this.builder,
    this.padding,
    this.expand = false,
    this.circular = false,
    this.minimumSize,
    this.borderSide,
    this.backgroundColor,
    this.foregroundColor,
    this.pressEffect = true,
    this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final side = borderSide ?? BorderSide.none;

    var content = builder?.call(context) ?? child ?? const SizedBox.shrink();
    if (expand) content = Center(child: content);

    final shape = circular
        ? CircleBorder(side: side)
        : RoundedRectangleBorder(
            side: side,
            borderRadius: BorderRadius.circular($appStyles.corners.sm),
          );

    final style = ButtonStyle(
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize ?? Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(
        padding ?? EdgeInsets.all($appStyles.insets.md),
      ),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      backgroundColor: ButtonStyleButton.allOrNull<Color>(
        backgroundColor ?? $appStyles.colors.primary,
      ),
      foregroundColor: ButtonStyleButton.allOrNull<Color>(
        foregroundColor ?? $appStyles.colors.offBlack,
      ),
      overlayColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: enableFeedback,
    );

    Widget button = _CustomFocusBuilder(
      builder: (context, focus) {
        return Stack(
          children: [
            TextButton(
              onPressed: onPressed,
              style: style,
              focusNode: focus,
              child: content,
            ),
            if (focus.hasFocus)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: $appStyles.colors.primary, width: 3),
                    borderRadius: BorderRadius.circular($appStyles.corners.md),
                  ),
                ),
              ),
          ],
        );
      },
    );

    // Add press effect
    if (pressEffect) button = _ButtonPressEffect(child: button);

    return button;
  }
}

class _ButtonPressEffect extends HookWidget {
  final Widget child;

  const _ButtonPressEffect({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDown = useState<bool>(false);

    return GestureDetector(
      onTapDown: (details) => isDown.value = true,
      onTapUp: (details) => isDown.value = false,
      onTapCancel: () => isDown.value = false,
      behavior: HitTestBehavior.translucent,
      child: Opacity(
        opacity: isDown.value ? 0.7 : 1,
        child: child,
      ),
    );
  }
}

class _CustomFocusBuilder extends HookWidget {
  final Widget Function(BuildContext context, FocusNode focus) builder;

  const _CustomFocusBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    return builder.call(context, focusNode);
  }
}
