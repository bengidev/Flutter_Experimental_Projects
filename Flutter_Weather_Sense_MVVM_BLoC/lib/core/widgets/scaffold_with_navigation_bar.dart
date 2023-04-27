import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavigationBar extends HookWidget {
  /// The [child] widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  /// Customize the [BottomNavigationBarType] with its provided options.
  /// The default value was [BottomNavigationBarType.fixed].
  final BottomNavigationBarType? navigationBarType;

  /// Customize the background color of [BottomNavigationBar].
  final Color? navigationBarBackgroundColor;

  /// Customize the shadow effect of [BottomNavigationBar]
  /// using its elevation value.
  final double? elevation;

  /// Customize the icon size of [BottomNavigationBar].
  /// The default value for icon size was 24.
  final double? iconSize;

  /// Customize the Color of [BottomNavigationBar]
  /// when [BottomNavigationBarItem] was selected.
  final Color? selectedItemColor;

  /// Customize the Color of [BottomNavigationBar]
  /// when [BottomNavigationBarItem] was unselected.
  final Color? unselectedItemColor;

  /// NavigationBarItems to show the list of [BottomNavigationBarItem].
  /// Each [BottomNavigationBarItem] contain its customized components.
  final List<BottomNavigationBarItem> navigationBarItems;

  /// You can navigating into another screen or page while pressed
  /// the icon of the [BottomNavigationBarItem] from its returned index.
  final void Function(int index)? onItemPressed;

  /// The index into items for the current active [BottomNavigationBarItem].
  final int? currentIndex;

  const ScaffoldWithNavigationBar({
    super.key,
    required this.child,
    this.navigationBarType,
    this.navigationBarBackgroundColor,
    this.elevation,
    this.iconSize,
    this.selectedItemColor,
    this.unselectedItemColor,
    required this.navigationBarItems,
    this.onItemPressed,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: navigationBarType ?? BottomNavigationBarType.fixed,
        backgroundColor: navigationBarBackgroundColor,
        elevation: elevation,
        iconSize: iconSize ?? 24.0,
        showSelectedLabels: false,
        // Hide selected label and center its icon.
        selectedItemColor: selectedItemColor,
        showUnselectedLabels: false,
        // Hide unselected label and center its icon.
        unselectedItemColor: unselectedItemColor,
        items: navigationBarItems,
        onTap: onItemPressed,
        currentIndex: currentIndex ?? 0,
      ),
    );
  }
}
