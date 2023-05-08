import 'package:flutter/foundation.dart';

class LocationDetailHelper {
  /// Test the static [buildLocationTitle] method
  /// of the [LocationDetailHelper]'s class.
  ///
  /// It will return the results from [buildLocationTitle].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  String testBuildLocationTitle({
    required String objectString,
  }) {
    return buildLocationTitle(objectString: objectString);
  }

  /// Build [String] from the given [objectString]
  /// and return the first index of splitted [objectString].
  static String buildLocationTitle({
    required String objectString,
  }) {
    final splittedStrings = objectString.split(',');
    final firstSplittedString = splittedStrings.first;
    return firstSplittedString;
  }

  /// Test the static [buildLocationSubTitle] method
  /// of the [LocationDetailHelper]'s class.
  ///
  /// It will return the results from [buildLocationSubTitle].
  ///
  /// This method only available for testing purpose only.
  @visibleForTesting
  String testBuildLocationSubTitle({
    required String objectString,
  }) {
    return buildLocationSubTitle(objectString: objectString);
  }

  /// Build [String] from the given [objectString]
  /// and return the rest of splitted [objectString],
  /// except the first index of splitted [objectString].
  static String buildLocationSubTitle({
    required String objectString,
  }) {
    final splittedStrings = objectString.split(', ');
    final skippedFirstStringList = splittedStrings.sublist(1);
    final mappedStringList =
        skippedFirstStringList.map<String>((e) => e).toString();
    return mappedStringList;
  }
}
