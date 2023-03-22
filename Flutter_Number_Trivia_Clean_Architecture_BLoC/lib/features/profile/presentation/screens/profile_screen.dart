import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfileScreen extends HookWidget {
  static const routeName = '/profile';
  static const _profileKey = Key('profileKey');

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ProfileScreen._profileKey,
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        useLogger(
            object:
                "ProfilePage Visibility -> ${info.key} is $visiblePercentage% visible");
      },
      child: const ScaffoldWithSafeArea(
        child: PaddedColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Profile Page"),
            ),
          ],
        ),
      ),
    );
  }
}
