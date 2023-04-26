import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/utilities/shared_preferences_storage/shared_preferences_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferencesStorage extends Mock
    implements SharedPreferencesStorage {}

void main() async {
  late MockSharedPreferencesStorage sharedPreferencesStorage;

  setUp(() {
    sharedPreferencesStorage = MockSharedPreferencesStorage();
  });

  group("Test shared preferences storage's functionality", () {
    test(
        'Given the instance of shared preferences storage, '
        'When the value of setWasOnboardingCompleted is true, '
        'Then it should return the Future value of boolean.', () async {
      // ARRANGE
      when(
        () => sharedPreferencesStorage.testSetWasOnboardingCompleted(
          wasCompleted: any(named: 'wasCompleted', that: isA<bool>()),
        ),
      ).thenAnswer((_) => Future<bool>.value(true));

      // ACT
      final results =
          await sharedPreferencesStorage.testSetWasOnboardingCompleted(
        wasCompleted: true,
      );

      // ASSERT
      expect(results, isTrue);
      verify(
        () => sharedPreferencesStorage.testSetWasOnboardingCompleted(
          wasCompleted: any(named: 'wasCompleted', that: isA<bool>()),
        ),
      ).called(1);
    });

    test(
        'Given the instance of shared preferences storage, '
        'When the value of setWasOnboardingCompleted is false, '
        'Then it should return the Future value of boolean.', () async {
      // ARRANGE
      when(
        () => sharedPreferencesStorage.testSetWasOnboardingCompleted(
          wasCompleted: any(named: 'wasCompleted', that: isA<bool>()),
        ),
      ).thenAnswer((_) => Future<bool>.value(false));

      // ACT
      final results =
          await sharedPreferencesStorage.testSetWasOnboardingCompleted(
        wasCompleted: false,
      );

      // ASSERT
      expect(results, isFalse);
      verify(
        () => sharedPreferencesStorage.testSetWasOnboardingCompleted(
          wasCompleted: any(named: 'wasCompleted', that: isA<bool>()),
        ),
      ).called(1);
    });

    test(
        'Given the instance of shared preferences storage, '
        'When the stored value of setWasOnboardingCompleted was available, '
        'Then it should return the stored value of boolean.', () async {
      // ARRANGE
      when(() => sharedPreferencesStorage.testGetWasOnboardingCompleted())
          .thenReturn(true);

      // ACT
      final results = sharedPreferencesStorage.testGetWasOnboardingCompleted();

      // ASSERT
      expect(results, isTrue);
      verify(() => sharedPreferencesStorage.testGetWasOnboardingCompleted())
          .called(1);
    });

    test(
        'Given the instance of shared preferences storage, '
        'When the stored value of setWasOnboardingCompleted was empty or null, '
        'Then it should return the stored value of boolean false.', () async {
      // ARRANGE
      when(() => sharedPreferencesStorage.testGetWasOnboardingCompleted())
          .thenReturn(false);

      // ACT
      final results = sharedPreferencesStorage.testGetWasOnboardingCompleted();

      // ASSERT
      expect(results, isFalse);
      verify(() => sharedPreferencesStorage.testGetWasOnboardingCompleted())
          .called(1);
    });
  });
}
