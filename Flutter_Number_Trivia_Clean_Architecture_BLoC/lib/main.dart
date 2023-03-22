// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:number_trivia_project/application.dart';
import 'package:number_trivia_project/application_bloc_observer.dart';
import 'package:number_trivia_project/dependency_injection.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen up until app is finished to load the setup.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize required setup.
  await initializeServiceLocator();

  // Track the BLoC state using its observer.
  Bloc.observer = ApplicationBlocObserver();

  // Once you've decided on the Google Fonts you want in your published app,
  // you should add the appropriate licenses to your flutter app's LicenseRegistry.
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // To help spot images that are too big for their rendering space.
  debugInvertOversizedImages = true;

  // To help determine if your boundaries are helping or not and
  // will visualize repaints as your app runs.
  // Watch for overly large repaint areas,
  // or areas repainting that haven’t actually changed visually.
  // debugRepaintRainbowEnabled = true;

  // Manage the Flutter Framework to keep app in portrait mode only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Start application normally.
  runApp(const Application());

  // Start application with DevicePreview.
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const Application(),
  //   ),
  // );

  // Remove splash screen when required setup is complete.
  FlutterNativeSplash.remove();
}
