import 'package:get_it/get_it.dart';

/// Global helpers for readability
GetIt get $serviceLocator => GetIt.instance;

/// Create singletons (logic and services) that can be shared across the app.
///
/// Run this function inside your main function and wait until the initialization process
/// has been completed.
///
Future<void> initializeServiceLocator() async {
  // Wait until all dependency registration was completed.
  await $serviceLocator.allReady();
}
