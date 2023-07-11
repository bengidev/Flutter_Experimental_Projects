import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:newsflix/core/core_barrel.dart';
import 'package:newsflix/dependency_injection.dart';
import 'package:sized_context/sized_context.dart';

class Application extends HookWidget {
  static AppStyles _styles = AppStyles();

  static AppStyles get styles => _styles;

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppGoRouter.builder.routeInformationProvider,
      routeInformationParser: AppGoRouter.builder.routeInformationParser,
      debugShowCheckedModeBanner: false,
      routerDelegate: AppGoRouter.builder.routerDelegate,
      builder: (context, child) {
        // Build AppStyles inside the application router.
        _buildAppStyles(context: context);

        // Return an empty Container when child Widget was empty.
        return DevicePreview.appBuilder(context, child);
      },
      theme: ThemeData(colorScheme: $appStyles.colors.lightColorScheme),
      darkTheme: ThemeData(colorScheme: $appStyles.colors.darkColorScheme),
    );
  }

  /// Build [AppStyles] to listen to the device size,
  /// and update [AppStyles] when it changes
  /// with retrieving the BuildContext instance from
  /// application's router.
  void _buildAppStyles({required BuildContext context}) {
    _styles = AppStyles(screenSize: context.sizePx);
  }
}
