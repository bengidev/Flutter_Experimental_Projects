import 'package:flutter/foundation.dart';

@immutable
class WeatherForecastHelper {
  static String generateWeatherImage({
    required int weatherCode,
    required String dayDescription,
  }) {
    switch (weatherCode) {
      case 0:
        return "assets/images/stars.svg";
      case 1:
      case 2:
      case 3:
        if (dayDescription.contains("morning")) {
          return "assets/images/partly_cloudy_day.svg";
        } else {
          return "assets/images/partly_cloudy_night.svg";
        }
      case 45:
      case 48:
        return "assets/images/hazzy.svg";
      case 51:
      case 53:
      case 55:
        return "assets/images/drops.svg";
      case 56:
      case 57:
        return "assets/images/drops.svg";
      case 61:
      case 63:
      case 65:
        if (dayDescription.contains("morning")) {
          return "assets/images/rainy_day.svg";
        } else {
          return "assets/images/rainy_night.svg";
        }
      case 66:
      case 67:
        if (dayDescription.contains("morning")) {
          return "assets/images/sleety_day.svg";
        } else {
          return "assets/images/sleety_night.svg";
        }
      case 71:
      case 73:
      case 75:
        return "assets/images/snow.svg";
      case 77:
        return "assets/images/snowy.svg";
      case 80:
      case 81:
      case 82:
        if (dayDescription.contains("morning")) {
          return "assets/images/rainy_day.svg";
        } else {
          return "assets/images/rainy_night.svg";
        }
      case 85:
      case 86:
        return "assets/images/snow.svg";
      case 95:
        if (dayDescription.contains("morning")) {
          return "assets/images/stormy_day.svg";
        } else {
          return "assets/images/stormy_night.svg";
        }
      case 96:
      case 99:
        if (dayDescription.contains("morning")) {
          return "assets/images/stormy_day.svg";
        } else {
          return "assets/images/stormy_night.svg";
        }
      default:
        return "assets/images/stars.svg";
    }
  }
}
