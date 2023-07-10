import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IntroScreen extends HookWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Material Theme Builder"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Update with your UI',
            ),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => {}, tooltip: 'Increment'),
    );
  }
}
