import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_screen.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/search_weather/views/search_weather_screen.dart';

class AppNavigationScreen extends HookWidget {
  const AppNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndexState = useState<int>(0);

    return ScaffoldWithNavigationBar(
      navigationBarItems:
          _buildNavigationBarItems(index: currentIndexState.value),
      currentIndex: currentIndexState.value,
      onItemPressed: (index) {
        currentIndexState.value = index;
        debugPrint("onItemPressed at index -> ${currentIndexState.value}");
      },
      child: SafeArea(
        child: IndexedStack(
          index: currentIndexState.value,
          children: _buildNavigationScreens(),
        ),
      ),
    );
  }

  /// Initialize [BottomNavigationBarItem] into [ScaffoldWithNavigationBar].
  /// It requires minimum item for at least two [BottomNavigationBarItem]
  /// to be able to interchange each other.
  List<BottomNavigationBarItem> _buildNavigationBarItems({
    required int index,
  }) {
    final navigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        label: "Home",
        icon: index == 0
            ? const Icon(Icons.home_rounded)
            : const Icon(Icons.home_outlined),
      ),
      BottomNavigationBarItem(
        label: "Search Weather",
        icon: index == 1
            ? const Icon(Icons.explore_rounded)
            : const Icon(Icons.explore_outlined),
      )
    ];
    return navigationBarItems;
  }

  /// Initialize [Widget] to be displayed on top of [ScaffoldWithNavigationBar].
  /// It requires minimum item for at least two [Widget]
  /// to be able to interchange each other.
  List<Widget> _buildNavigationScreens() {
    const screens = <Widget>[
      HomeScreen(),
      SearchWeatherScreen(),
    ];

    return screens;
  }
}
