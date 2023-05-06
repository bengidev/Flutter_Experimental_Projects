import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';

void main() {
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
}
