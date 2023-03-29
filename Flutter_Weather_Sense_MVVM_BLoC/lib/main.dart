import 'package:flutter/material.dart';
import 'package:flutter_weather_sense_mvvm_bloc/application.dart';

void main() async {
  // If no binding has yet been initialized,
  // the [WidgetsFlutterBinding] class is used to create and initialize one.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());
}
