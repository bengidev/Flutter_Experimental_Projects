import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_project/core/errors/exception.dart';
import 'package:number_trivia_project/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:number_trivia_project/features/number_trivia/data/models/number_trivia_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      numberTriviaRemoteDataSourceImpl =
          NumberTriviaRemoteDataSourceImpl(httpClient: mockHttpClient);
    },
  );

  const tSuccessRawData =
      '{"text": "test description","number": 1, "found": true, "type": "trivia"}';
  const tNumber = 1;
  final tNumberTriviaModel = NumberTriviaModel.fromJson(
    json.decode(tSuccessRawData) as Map<String, dynamic>,
  );

  void setUpMockHttpClientSuccess200() {
    const responseCode = 200;
    final responseResult = http.Response(tSuccessRawData, responseCode);

    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => responseResult);
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenThrow(ServerException());
  }

  group(
      'Testing number trivia remote data source impl of concrete number trivia',
      () {
    test(
      'Given a URL with concrete number being the endpoint, '
      'When it reach the server successfully, '
      'Then it should interact to the server.',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(
          number: tNumber,
        );

        // ASSERT
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
      },
    );

    test(
      'Given a URL with concrete number being the endpoint, '
      'When it reach the server successfully, '
      'Then it should return the number trivia model and response code is 200.',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        final result =
            await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(
          number: tNumber,
        );

        // ASSERT
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'Given a URL with concrete number being the endpoint, '
      'When it failure to reach the server, '
      'Then it should throw a server exception when the response code is 404.',
      () async {
        // ARRANGE
        setUpMockHttpClientFailure404();

        // ACT
        final execute =
            numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia;

        // ASSERT
        expect(() => execute(number: tNumber), throwsA(isA<ServerException>()));
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
      },
    );
  });

  group('Testing number trivia remote data source impl of random number trivia',
      () {
    test(
      'Given a URL with random being the endpoint, '
      'When it reach the server successfully, '
      'Then it should interact to the server.',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();

        // ASSERT
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
      },
    );

    test(
      'Given a URL with random being the endpoint, '
      'When it reach the server successfully, '
      'Then it should return the number trivia model and response code is 200.',
      () async {
        // ARRANGE
        setUpMockHttpClientSuccess200();

        // ACT
        final result =
            await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();

        // ASSERT
        expect(result, tNumberTriviaModel);
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
      },
    );

    test(
      'Given a URL with random being the endpoint, '
      'When it failure to reach the server, '
      'Then it should throw a server exception when the response code is 404.',
      () async {
        // ARRANGE
        setUpMockHttpClientFailure404();

        // ACT
        final execute = numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia;

        // ASSERT
        expect(() => execute(), throwsA(isA<ServerException>()));
        verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
            .called(1);
      },
    );
  });
}
