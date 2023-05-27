import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';

void main() async {
  group('Testing SearchGeocodingLocationEvent', () {
    test(
        'Given the instance of Home Bloc, '
        'When SearchGeocodingLocationEvent was added, '
        'Then it should supports value equality from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const SearchGeocodingLocationEvent(location: 'pontianak'),
        equals(const SearchGeocodingLocationEvent(location: 'pontianak')),
      );
    });

    test(
        'Given the instance of Home Bloc, '
        'When SearchGeocodingLocationEvent was added, '
        'Then it should correct the props from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const SearchGeocodingLocationEvent(location: 'pontianak').props,
        equals(<Object?>['pontianak']),
      );
    });
  });

  group('Testing FindHourlyWeatherForecastEvent', () {
    test(
        'Given the instance of Home Bloc, '
        'When FindHourlyWeatherForecastEvent was added, '
        'Then it should supports value equality from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0),
        equals(const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0)),
      );
    });

    test(
        'Given the instance of Home Bloc, '
        'When FindHourlyWeatherForecastEvent was added, '
        'Then it should correct the props from its event', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0).props,
        equals(<Object?>[0, 0]),
      );
    });
  });
}
