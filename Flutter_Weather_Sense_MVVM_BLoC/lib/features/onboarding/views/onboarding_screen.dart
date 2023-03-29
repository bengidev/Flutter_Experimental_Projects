import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "${counter.value}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text("Increment"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
