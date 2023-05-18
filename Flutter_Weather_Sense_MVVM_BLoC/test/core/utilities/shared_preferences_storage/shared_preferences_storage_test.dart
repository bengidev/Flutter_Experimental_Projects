import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferencesStorage extends Mock
    implements SharedPreferencesStorage {}

void main() async {
  late MockSharedPreferencesStorage sharedPreferencesStorage;

  ForwardFeature buildMockModelForwardFeature() {
    return const ForwardFeature(
      id: '',
      type: '',
      placeType: <String>[],
      relevance: 0,
      properties: ForwardProperty(wikidata: '', mapboxId: ''),
      text: '',
      placeName: '',
      bbox: <double>[],
      center: <double>[],
      geometry: ForwardGeometry(type: '', coordinates: <double>[]),
      context: <ForwardContext>[],
    );
  }

  setUp(() {
    sharedPreferencesStorage = MockSharedPreferencesStorage();
  });

  setUpAll(() {
    registerFallbackValue(buildMockModelForwardFeature());
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
      );
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
      );
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
      verify(() => sharedPreferencesStorage.testGetWasOnboardingCompleted());
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

  test(
      'Given the instance of shared preferences storage, '
      'When the value of setLatestModelForwardFeature was successfully saved, '
      'Then it should return the Future value of boolean.', () async {
    // ARRANGE
    when(
      () => sharedPreferencesStorage.testSetLatestModelForwardFeature(
        modelFeature: buildMockModelForwardFeature(),
      ),
    ).thenAnswer((_) => Future<bool>.value(true));

    // ACT
    final results =
        await sharedPreferencesStorage.testSetLatestModelForwardFeature(
      modelFeature: buildMockModelForwardFeature(),
    );

    // ASSERT
    expect(results, isTrue);
    verify(
      () => sharedPreferencesStorage.testSetLatestModelForwardFeature(
        modelFeature: any(named: 'modelFeature', that: isA<ForwardFeature>()),
      ),
    );
  });

  test(
      'Given the instance of shared preferences storage, '
      'When the value of SetLatestModelForwardFeature was available, '
      'Then it should return the relevant value of ForwardFeature.', () async {
    // ARRANGE
    when(() => sharedPreferencesStorage.testGetLatestModelForwardFeature())
        .thenReturn(buildMockModelForwardFeature());

    // ACT
    final results = sharedPreferencesStorage.testGetLatestModelForwardFeature();

    // ASSERT
    expect(results, isA<ForwardFeature>());
    expect(results, equals(buildMockModelForwardFeature()));
    verify(() => sharedPreferencesStorage.testGetLatestModelForwardFeature());
  });

  test(
      'Given the instance of shared preferences storage, '
      'When the value of SetLatestModelForwardFeature was empty or null, '
      'Then it should return the empty value of ForwardFeature.', () async {
    // ARRANGE
    when(() => sharedPreferencesStorage.testGetLatestModelForwardFeature())
        .thenReturn(buildMockModelForwardFeature());

    // ACT
    final results = sharedPreferencesStorage.testGetLatestModelForwardFeature();

    // ASSERT
    expect(results, isA<ForwardFeature>());
    expect(results, equals(buildMockModelForwardFeature()));
    verify(() => sharedPreferencesStorage.testGetLatestModelForwardFeature());
  });
}
