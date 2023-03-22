import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourceImpl;

  setUp(
    () {
      mockSharedPreferences = MockSharedPreferences();
      numberTriviaLocalDataSourceImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    },
  );

  const tNumber = 1;
  const tSuccessRawData =
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
  const tStringNumberTriviaModels =
      '[{"text": "test description","number": 1, "found": true, "type": "trivia"}, '
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}, '
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}]';
  final tNumberTriviaModel = NumberTriviaModel.fromJson(
    json.decode(tSuccessRawData) as Map<String, dynamic>,
  );

  group('Testing cacheNumberTrivia', () {
    test(
      'Given the data of number trivia model, '
      'When the instance of shared preferences is available, '
      'Then it should cache the data of number trivia model into local device storage.',
      () async {
        // ARRANGE
        when(() => mockSharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        // ACT
        final result = await numberTriviaLocalDataSourceImpl.cacheNumberTrivia(
          triviaToCache: tNumberTriviaModel,
        );

        // Assert
        expect(result, isTrue);
        verify(() => mockSharedPreferences.setString(any(), any())).called(1);
      },
    );
  });

  group('Testing getLastNumberTrivia', () {
    test(
      'Given the instance of shared preferences, '
      'When its instance contains the raw data of number trivia model, '
      'Then it should return the raw data cache of number trivia model.',
      () async {
        // ARRANGE
        when(() => mockSharedPreferences.getString(any()))
            .thenAnswer((_) => tSuccessRawData);

        // ACT
        final result =
            await numberTriviaLocalDataSourceImpl.getLastNumberTrivia();

        // ASSERT
        expect(result, equals(tNumberTriviaModel));
        verify(() => mockSharedPreferences.getString(any())).called(1);
      },
    );

    test(
      'Given the instance of shared preferences, '
      'When its instance isn\t contains the raw data of number trivia model, '
      'Then it should throw the cache exception.',
      () async {
        // ARRANGE
        when(() => mockSharedPreferences.getString(any())).thenReturn(null);

        // ACT
        final execute = numberTriviaLocalDataSourceImpl.getLastNumberTrivia;

        // ASSERT
        expect(() => execute(), throwsA(isA<CacheException>()));
        verify(() => mockSharedPreferences.getString(any())).called(1);
      },
    );
  });

  group('Testing storeNumberTriviaRecord', () {
    test(
      'Given the instance of local device storage, '
      'When the data of number trivia model was available, '
      'Then it should store the data record of number trivia model into local device storage.',
      () async {
        // ARRANGE
        when(() => mockSharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        // ACT
        final result = await numberTriviaLocalDataSourceImpl
            .storeNumberTriviaRecord(triviaToStore: tNumberTriviaModel);

        // Assert
        expect(result, isTrue);
        verify(() => mockSharedPreferences.getString(any())).called(1);
        verify(() => mockSharedPreferences.setString(any(), any())).called(1);
        verifyNoMoreInteractions(mockSharedPreferences);
      },
    );
  });

  group('Testing collectNumberTriviaRecords', () {
    test(
      'Given the instance of local device storage, '
      'When the data of number trivia model was available, '
      'Then it should return the data records of number trivia model.',
      () async {
        // ARRANGE
        when(() => mockSharedPreferences.getString(any()))
            .thenReturn(tStringNumberTriviaModels);

        // ACT
        final result =
            await numberTriviaLocalDataSourceImpl.collectNumberTriviaRecords();

        // ASSERT
        expect(result, isA<List<NumberTriviaModel>>());
        verify(() => mockSharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(mockSharedPreferences);
      },
    );
  });
}
