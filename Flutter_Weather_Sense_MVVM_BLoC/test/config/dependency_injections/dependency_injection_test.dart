import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/onboarding/views/onboarding_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() async {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  group("Testing initializeServiceLocator's function", () {
    test(
        'Given SharedPreferences instance, '
        'When inserting a String value into its instance contains ${OnboardingScreen.onboardingCompletedKey}, '
        'Then it will verified.', () async {
      // ARRANGE
      when(
        () => mockSharedPreferences.setBool(
          any(that: isA<String>()),
          any(that: isA<bool>()),
        ),
      ).thenAnswer(
        (invocation) => Future<bool>.value(true),
      );

      // ACT
      final result = await mockSharedPreferences.setBool(
        OnboardingScreen.onboardingCompletedKey,
        true,
      );

      // ASSERT
      expect(result, isTrue);
      verify(
        () => mockSharedPreferences.setBool(
          any(that: isA<String>()),
          any(that: isA<bool>()),
        ),
      );
    });

    test(
        'Given SharedPreferences instance, '
        'When its instance contains boolean of ${OnboardingScreen.onboardingCompletedKey}, '
        'Then it will return true.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.getBool(any(that: isA<String>())))
          .thenReturn(true);

      // ACT
      final result = mockSharedPreferences
          .getBool(OnboardingScreen.onboardingCompletedKey);

      // ASSERT
      expect(result, isTrue);
      verify(() => mockSharedPreferences.getBool(any(that: isA<String>())))
          .called(1);
    });

    test(
        'Given SharedPreferences instance, '
        'When its instance not contains boolean of ${OnboardingScreen.onboardingCompletedKey}, '
        'Then it will return false.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.getBool(any(that: isA<String>())))
          .thenReturn(false);

      // ACT
      final result = mockSharedPreferences
          .getBool(OnboardingScreen.onboardingCompletedKey);

      // ASSERT
      expect(result, isFalse);
      verify(() => mockSharedPreferences.getBool(any(that: isA<String>())))
          .called(1);
    });
  });
}
