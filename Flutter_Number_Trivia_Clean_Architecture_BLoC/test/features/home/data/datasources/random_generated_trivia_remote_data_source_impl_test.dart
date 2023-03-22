import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/core_barrel.dart';
import 'package:number_trivia_project/features/home/data/datasources/random_generated_trivia_remote_data_source_impl.dart';
import 'package:number_trivia_project/features/home/data/models/random_generated_trivia_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late RandomGeneratedTriviaRemoteDataSourceImpl
      randomGeneratedTriviaRemoteDataSourceImpl;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    randomGeneratedTriviaRemoteDataSourceImpl =
        RandomGeneratedTriviaRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  const tSuccessRawData =
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
  const tFailureRawData = 'Something went wrong';
  final decodeRawData = json.decode(tSuccessRawData) as Map<String, dynamic>;
  final tRandomGeneratedTriviaModel =
      RandomGeneratedTriviaModel.fromMap(decodeRawData);

  void arrangeHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(tSuccessRawData, 200));
  }

  void arrangeHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(tFailureRawData, 404));
  }

  group('Testing random generated trivia remote data source impl', () {
    test(
        'Given generated random number , '
        'When internet connection is available, '
        'Then it should reach the server successfully.', () async {
      // ARRANGE
      arrangeHttpClientSuccess200();

      // ACT
      await randomGeneratedTriviaRemoteDataSourceImpl
          .getRandomGeneratedTrivia();

      // ASSERT
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test(
        'Given generated random number, '
        'When response from external API is 200 or Successful, '
        'Then it should return raw data from external API.', () async {
      // ARRANGE
      arrangeHttpClientSuccess200();

      // ACT
      final result = await randomGeneratedTriviaRemoteDataSourceImpl
          .getRandomGeneratedTrivia();

      // ASSERT
      expect(result, tRandomGeneratedTriviaModel);
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test(
        'Given generated random number, '
        'When response from external is failure, '
        'Then it should throw Server Exception.', () async {
      // ARRANGE
      arrangeHttpClientFailure404();

      // ACT
      final execute =
          randomGeneratedTriviaRemoteDataSourceImpl.getRandomGeneratedTrivia;

      // ASSERT
      expect(
        () => execute(),
        throwsA(isA<ServerException>()),
      );
      verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });

  test(
      'Given range number, '
      'When range min and range max was added, '
      'Then it should return random number within its range.', () async {
    // ARRANGE

    // ACT
    final hasActualResult = randomGeneratedTriviaRemoteDataSourceImpl
        .generateRandomNumberTest(0, 25);

    // ASSERT
    expect(hasActualResult, inInclusiveRange(0, 25));
  });
}
