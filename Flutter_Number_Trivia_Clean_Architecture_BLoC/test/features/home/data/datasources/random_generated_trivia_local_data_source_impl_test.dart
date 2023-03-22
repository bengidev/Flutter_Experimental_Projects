import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/random_generated_trivia_local_data_source_impl.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late RandomGeneratedTriviaLocalDataSourceImpl
      randomGenerateTriviaLocalDataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    randomGenerateTriviaLocalDataSourceImpl =
        RandomGeneratedTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const tGeneratedTriviaRawData =
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
  const tRandomGeneratedTriviaModel = RandomGeneratedTriviaModel(
    text: "test description",
    number: 1,
  );

  group('Testing for manipulating data using Shared Preferences', () {
    test(
        'Given the data object to be stored and the key has been determined, '
        'When the process inside Shared Preferences has no errors, '
        'Then it should return the future of boolean true.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(true));

      // ACT
      final actualResult = await randomGenerateTriviaLocalDataSourceImpl
          .cacheRandomGeneratedTrivia(tRandomGeneratedTriviaModel);

      // ASSERT
      expect(actualResult, isTrue);
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });

    test(
        'Given the data object to be stored and the key has been determined, '
        'When the process inside Shared Preferences has errors of Cache Exception, '
        'Then it should throw the Cache Exception.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) => Future.value(false));

      // ACT
      final actualResult =
          randomGenerateTriviaLocalDataSourceImpl.cacheRandomGeneratedTrivia;

      // ASSERT
      expect(
        () => actualResult(tRandomGeneratedTriviaModel),
        throwsA(isA<CacheException>()),
      );
      verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    });

    test(
        'Given the data object has been stored and the key has been determined, '
        'When the process inside Shared Preferences has no errors, '
        'Then it should return the value of stored data.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.getString(any()))
          .thenAnswer((_) => tGeneratedTriviaRawData);

      // ACT
      final actualResult = await randomGenerateTriviaLocalDataSourceImpl
          .getLastRandomGeneratedTrivia();

      // ASSERT
      expect(
        actualResult,
        isA<RandomGeneratedTriviaModel>(),
      );
      verify(() => mockSharedPreferences.getString(any())).called(1);
    });

    test(
        'Given the data object has been stored and the key has been determined, '
        'When the process inside Shared Preferences has errors of Cache Exception, '
        'Then it should throw the Cache Exception.', () async {
      // ARRANGE
      when(() => mockSharedPreferences.getString(any()))
          .thenAnswer((_) => null);

      // ACT
      final actualResult =
          randomGenerateTriviaLocalDataSourceImpl.getLastRandomGeneratedTrivia;

      // ASSERT
      expect(
        () => actualResult(),
        throwsA(isA<CacheException>()),
      );
      verify(() => mockSharedPreferences.getString(any())).called(1);
    });
  });
}
