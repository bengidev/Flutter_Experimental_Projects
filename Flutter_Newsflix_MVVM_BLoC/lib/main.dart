import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:newsflix/application.dart';

void main() async {
  // If no binding has yet been initialized,
  // the [WidgetsFlutterBinding] class is used to create and initialize one.
  final widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen showing up until the app was finished to load the setup.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);

  //Start running the application.
  //
  // Wrap the whole application screen with [DevicePreview]
  // to be able to view the application running inside
  // the different [Platform].
  runApp(
    DevicePreview(
      builder: (context) => const Application(),
    ),
  );

  // Remove splash screen when the required setup is complete
  // and the splash screen was finished to showing up.
  FlutterNativeSplash.remove();
}
