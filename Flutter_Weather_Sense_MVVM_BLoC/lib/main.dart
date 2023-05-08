import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather_sense_mvvm_bloc/application.dart';
import 'package:flutter_weather_sense_mvvm_bloc/application_bloc_observer.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';

void main() async {
  // If no binding has yet been initialized,
  // the [WidgetsFlutterBinding] class is used to create and initialize one.
  final widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash screen showing up until the app was finished to load the setup.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);

  // Wait the Service Locator which is using get_it package
  // to finished its initialization setup before launch the app.
  await DependencyInjection.initializeDependencies();

  // Observe the transition of all bloc activities
  // inside the application.
  // It will show the traces by using the
  // debugPrint functionality.
  Bloc.observer = ApplicationBlocObserver();

  // Once you've decided on the Google Fonts you want in your published app,
  // you should add the appropriate licenses to your flutter app's LicenseRegistry.
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Manage the Flutter Framework to keep the app to run in portrait mode only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //Start running the application.
  runApp(const Application());

  // Remove splash screen when the required setup is complete
  // and the splash screen was finished to showing up.
  FlutterNativeSplash.remove();
}
