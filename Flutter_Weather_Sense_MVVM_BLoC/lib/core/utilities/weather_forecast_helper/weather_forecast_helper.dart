import 'package:flutter/foundation.dart';

enum _WeatherInterpretation {
  zero(
    code: 0,
    description: "Clear Sky",
    dayImageAsset: "assets/images/stars.svg",
    nightImageAsset: "assets/images/stars.svg",
  ),
  one(
    code: 1,
    description: "Mainly Clear",
    dayImageAsset: "assets/images/partly_cloudy_night.svg",
    nightImageAsset: "assets/images/partly_cloudy_day.svg",
  ),
  two(
    code: 2,
    description: "Partly Cloudy",
    dayImageAsset: "assets/images/partly_cloudy_night.svg",
    nightImageAsset: "assets/images/partly_cloudy_day.svg",
  ),
  three(
    code: 3,
    description: "Overcast",
    dayImageAsset: "assets/images/partly_cloudy_night.svg",
    nightImageAsset: "assets/images/partly_cloudy_day.svg",
  ),
  fourtyFive(
    code: 45,
    description: "Fog",
    dayImageAsset: "assets/images/hazzy.svg",
    nightImageAsset: "assets/images/hazzy.svg",
  ),
  fourtyEight(
    code: 48,
    description: "Rime Fog",
    dayImageAsset: "assets/images/hazzy.svg",
    nightImageAsset: "assets/images/hazzy.svg",
  ),
  fiftyOne(
    code: 51,
    description: "Drizzle Light",
    dayImageAsset: "assets/images/drops.svg",
    nightImageAsset: "assets/images/drops.svg",
  ),
  fiftyThree(
    code: 53,
    description: "Drizzle Moderate",
    dayImageAsset: "assets/images/drops.svg",
    nightImageAsset: "assets/images/drops.svg",
  ),
  fiftyFive(
    code: 55,
    description: "Drizzle Dense",
    dayImageAsset: "assets/images/drops.svg",
    nightImageAsset: "assets/images/drops.svg",
  ),
  fiftySix(
    code: 56,
    description: "Freezing Drizzle Light",
    dayImageAsset: "assets/images/drops.svg",
    nightImageAsset: "assets/images/drops.svg",
  ),
  fiftySeven(
    code: 57,
    description: "Freezing Drizzle Dense",
    dayImageAsset: "assets/images/drops.svg",
    nightImageAsset: "assets/images/drops.svg",
  ),
  sixtyOne(
    code: 61,
    description: "Rain Slight",
    dayImageAsset: "assets/images/sleety_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  sixtyThree(
    code: 63,
    description: "Rain Moderate",
    dayImageAsset: "assets/images/sleety_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  sixtyFive(
    code: 65,
    description: "Rain Heavy",
    dayImageAsset: "assets/images/rainy_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  sixtySix(
    code: 66,
    description: "Freezing Rain Light",
    dayImageAsset: "assets/images/sleety_day.svg",
    nightImageAsset: "assets/images/sleety_night.svg",
  ),
  sixtySeven(
    code: 67,
    description: "Freezing Rain Heavy",
    dayImageAsset: "assets/images/sleety_day.svg",
    nightImageAsset: "assets/images/sleety_night.svg",
  ),
  seventyOne(
    code: 71,
    description: "Snow Fall Slight",
    dayImageAsset: "assets/images/snow.svg",
    nightImageAsset: "assets/images/snow.svg",
  ),
  seventyThree(
    code: 73,
    description: "Snow Fall Moderate",
    dayImageAsset: "assets/images/snow.svg",
    nightImageAsset: "assets/images/snow.svg",
  ),
  seventyFive(
    code: 75,
    description: "Snow Fall Heavy",
    dayImageAsset: "assets/images/snow.svg",
    nightImageAsset: "assets/images/snow.svg",
  ),
  seventySeven(
    code: 77,
    description: "Snow Grains",
    dayImageAsset: "assets/images/snowy.svg",
    nightImageAsset: "assets/images/snowy.svg",
  ),
  eighty(
    code: 80,
    description: "Rain Showers Slight",
    dayImageAsset: "assets/images/rainy_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  eightyOne(
    code: 81,
    description: "Rain Showers Moderate",
    dayImageAsset: "assets/images/rainy_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  eightyTwo(
    code: 82,
    description: "Rain Showers Violent",
    dayImageAsset: "assets/images/rainy_day.svg",
    nightImageAsset: "assets/images/rainy_night.svg",
  ),
  eightyFive(
    code: 85,
    description: "Snow Showers Slight",
    dayImageAsset: "assets/images/snow.svg",
    nightImageAsset: "assets/images/snow.svg",
  ),
  eightySix(
    code: 86,
    description: "Snow Showers Heavy",
    dayImageAsset: "assets/images/snow.svg",
    nightImageAsset: "assets/images/snow.svg",
  ),
  ninetyFive(
    code: 95,
    description: "Thunderstorm Slight or Moderate",
    dayImageAsset: "assets/images/stormy_day.svg",
    nightImageAsset: "assets/images/stormy_night.svg",
  ),
  ninetySix(
    code: 96,
    description: "Thunderstorm with Slight Hail",
    dayImageAsset: "assets/images/stormy_day.svg",
    nightImageAsset: "assets/images/stormy_night.svg",
  ),
  ninetyNine(
    code: 99,
    description: "Thunderstorm with Heavy Hail",
    dayImageAsset: "assets/images/stormy_day.svg",
    nightImageAsset: "assets/images/stormy_night.svg",
  ),
  other(
    code: 0,
    description: "Full of Stars",
    dayImageAsset: "assets/images/stars.svg",
    nightImageAsset: "assets/images/stars.svg",
  );

  const _WeatherInterpretation({
    required this.code,
    required this.description,
    required this.dayImageAsset,
    required this.nightImageAsset,
  });

  final int code;
  final String description;
  final String dayImageAsset;
  final String nightImageAsset;
}

@immutable
class WeatherForecastHelper {
  static String generateWeatherImage({
    required int weatherCode,
    required String dayDescription,
  }) {
    switch (weatherCode) {
      case 0:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.zero.nightImageAsset;
        } else {
          return _WeatherInterpretation.zero.dayImageAsset;
        }
      case 1:
      case 2:
      case 3:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.three.nightImageAsset;
        } else {
          return _WeatherInterpretation.three.dayImageAsset;
        }
      case 45:
      case 48:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.fourtyEight.nightImageAsset;
        } else {
          return _WeatherInterpretation.fourtyEight.dayImageAsset;
        }
      case 51:
      case 53:
      case 55:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.fiftyFive.nightImageAsset;
        } else {
          return _WeatherInterpretation.fiftyFive.dayImageAsset;
        }
      case 56:
      case 57:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.fiftySeven.nightImageAsset;
        } else {
          return _WeatherInterpretation.fiftySeven.dayImageAsset;
        }
      case 61:
      case 63:
      case 65:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.sixtyFive.nightImageAsset;
        } else {
          return _WeatherInterpretation.sixtyFive.dayImageAsset;
        }
      case 66:
      case 67:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.sixtySeven.nightImageAsset;
        } else {
          return _WeatherInterpretation.sixtySeven.dayImageAsset;
        }
      case 71:
      case 73:
      case 75:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.seventyFive.nightImageAsset;
        } else {
          return _WeatherInterpretation.seventyFive.dayImageAsset;
        }
      case 77:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.seventySeven.nightImageAsset;
        } else {
          return _WeatherInterpretation.seventySeven.dayImageAsset;
        }
      case 80:
      case 81:
      case 82:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.eightyTwo.nightImageAsset;
        } else {
          return _WeatherInterpretation.eightyTwo.dayImageAsset;
        }
      case 85:
      case 86:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.eightySix.nightImageAsset;
        } else {
          return _WeatherInterpretation.eightySix.dayImageAsset;
        }
      case 95:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.ninetyFive.nightImageAsset;
        } else {
          return _WeatherInterpretation.ninetyFive.dayImageAsset;
        }
      case 96:
      case 99:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.ninetyNine.nightImageAsset;
        } else {
          return _WeatherInterpretation.ninetyNine.dayImageAsset;
        }
      default:
        if (dayDescription.contains("Evening")) {
          return _WeatherInterpretation.other.nightImageAsset;
        } else {
          return _WeatherInterpretation.other.dayImageAsset;
        }
    }
  }

  static String generateWeatherDescription({
    required int weatherCode,
  }) {
    switch (weatherCode) {
      case 0:
        return _WeatherInterpretation.zero.description;
      case 1:
        return _WeatherInterpretation.one.description;
      case 2:
        return _WeatherInterpretation.two.description;
      case 3:
        return _WeatherInterpretation.three.description;
      case 45:
        return _WeatherInterpretation.fourtyFive.description;
      case 48:
        return _WeatherInterpretation.fourtyEight.description;
      case 51:
        return _WeatherInterpretation.fiftyOne.description;
      case 53:
        return _WeatherInterpretation.fiftyThree.description;
      case 55:
        return _WeatherInterpretation.fiftyFive.description;
      case 56:
        return _WeatherInterpretation.fiftySix.description;
      case 57:
        return _WeatherInterpretation.fiftySeven.description;
      case 61:
        return _WeatherInterpretation.sixtyOne.description;
      case 63:
        return _WeatherInterpretation.sixtyThree.description;
      case 65:
        return _WeatherInterpretation.sixtyFive.description;
      case 66:
        return _WeatherInterpretation.sixtySix.description;
      case 67:
        return _WeatherInterpretation.sixtySeven.description;
      case 71:
        return _WeatherInterpretation.seventyOne.description;
      case 73:
        return _WeatherInterpretation.seventyThree.description;
      case 75:
        return _WeatherInterpretation.seventyFive.description;
      case 77:
        return _WeatherInterpretation.seventySeven.description;
      case 80:
        return _WeatherInterpretation.eighty.description;
      case 81:
        return _WeatherInterpretation.eightyOne.description;
      case 82:
        return _WeatherInterpretation.eightyTwo.description;
      case 85:
        return _WeatherInterpretation.eightyFive.description;
      case 86:
        return _WeatherInterpretation.eightySix.description;
      case 95:
        return _WeatherInterpretation.ninetyFive.description;
      case 96:
        return _WeatherInterpretation.ninetySix.description;
      case 99:
        return _WeatherInterpretation.ninetyNine.description;
      default:
        return _WeatherInterpretation.other.description;
    }
  }
}
