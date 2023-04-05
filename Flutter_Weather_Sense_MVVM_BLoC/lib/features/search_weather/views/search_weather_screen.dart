import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:go_router/go_router.dart';

class SearchWeatherScreen extends HookWidget {
  const SearchWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Search Weather Screen"),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRouter.homePath);
                },
                child: const Text("Go To Home Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
