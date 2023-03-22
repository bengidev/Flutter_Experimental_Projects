import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/dependency_injection.dart';
import 'package:number_trivia_project/features/home/presentation/screens/home_screen.dart';
import 'package:number_trivia_project/features/home/presentation/widgets/detail_featured_trivia.dart';
import 'package:number_trivia_project/features/number_trivia/presentation/screens/number_trivia_screen.dart';
import 'package:number_trivia_project/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:number_trivia_project/features/profile/presentation/screens/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppNavigationBar extends HookWidget {
  static const routeName = '/appNavigationBar';

  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final persistentTabController = useState(
      PersistentTabController(initialIndex: 0),
    );

    return PersistentTabView(
      context,
      controller: persistentTabController.value,
      screens: _buildPages(),
      items: _navBarsItems(
        context: context,
      ),
      confineInSafeArea: true,
      // Default is Colors.white.
      backgroundColor: $styles.colors.primary,
      // Default is true.
      handleAndroidBackButtonPress: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      resizeToAvoidBottomInset: false,
      // Default is true.
      stateManagement: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      hideNavigationBarWhenKeyboardShows: false,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular($styles.insets.sm),
        colorBehindNavBar: $styles.colors.offBlack,
        boxShadow: kElevationToShadow[6],
        border: Border.all(
          color: $styles.colors.offBlack,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      // Navigation Bar's items animation properties.
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      // Screen transition animation on change of selected tab.
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      // Choose the nav bar style with this property.
      navBarStyle: NavBarStyle.style9,
    );
  }

  List<Widget> _buildPages() {
    return [
      const HomeScreen(),
      const NumberTriviaScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems({
    required BuildContext context,
  }) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FluentIcons.home_person_20_regular),
        title: "Home",
        activeColorPrimary: $styles.colors.offWhite,
        inactiveColorPrimary: $styles.colors.greyMedium,
        routeAndNavigatorSettings: _buildRouteAndNavigatorSettings(
          context: context,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FluentIcons.book_number_20_regular),
        title: "Trivia",
        activeColorPrimary: $styles.colors.offWhite,
        inactiveColorPrimary: $styles.colors.greyMedium,
        routeAndNavigatorSettings: _buildRouteAndNavigatorSettings(
          context: context,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FluentIcons.person_available_20_regular),
        title: "Profile",
        activeColorPrimary: $styles.colors.offWhite,
        inactiveColorPrimary: $styles.colors.greyMedium,
        routeAndNavigatorSettings: _buildRouteAndNavigatorSettings(
          context: context,
        ),
      ),
    ];
  }

  RouteAndNavigatorSettings _buildRouteAndNavigatorSettings({
    required BuildContext context,
  }) {
    return RouteAndNavigatorSettings(
      initialRoute: AppNavigationBar.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppNavigationBar.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const AppNavigationBar(),
            );
          case OnboardingScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const OnboardingScreen(),
            );
          case HomeScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const HomeScreen(),
            );
          case DetailFeaturedTrivia.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              fullScreenDialog: true,
              settings: settings,
              context: context,
              child: () {
                final args = settings.arguments as Map<String, dynamic>?;
                return DetailFeaturedTrivia(
                  number: args?['number'].toString(),
                  triviaDescription: args?['triviaDescription'].toString(),
                );
              },
            );
          case NumberTriviaScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const NumberTriviaScreen(),
            );
          case ProfileScreen.routeName:
            return AppRouteBuilder.buildWithSlideTransition(
              settings: settings,
              context: context,
              child: () => const ProfileScreen(),
            );
        }
        return null;
      },
    );
  }
}
