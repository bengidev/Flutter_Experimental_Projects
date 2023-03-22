import 'package:flutter/material.dart';
import 'package:number_trivia_project/dependency_injection.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    Key? key,
    String? message,
    TextStyle? messageStyle,
    Duration? duration,
    Function()? onPressed,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar(
        key: key,
        message: message,
        messageStyle: messageStyle,
        duration: duration,
        onPressed: onPressed,
      ),
    );
  }

  static SnackBar _buildSnackBar({
    Key? key,
    String? message,
    TextStyle? messageStyle,
    Duration? duration,
    Function()? onPressed,
  }) {
    return SnackBar(
      key: key,
      margin: EdgeInsets.only(
        left: $styles.insets.sm,
        bottom: $styles.insets.lg,
        right: $styles.insets.sm,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      content: Text(
        message ?? "Default Message",
        style: messageStyle ?? $styles.textStyle.title1,
      ),
      elevation: 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey,
      duration: duration ?? $styles.times.fast,
      action: SnackBarAction(
        textColor: Colors.black,
        label: "OK",
        onPressed: onPressed ?? () {},
      ),
    );
  }
}
