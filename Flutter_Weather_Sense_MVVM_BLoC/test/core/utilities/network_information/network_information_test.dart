import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkInformation extends Mock implements NetworkInformation {}

void main() {
  late MockNetworkInformation networkInformation;

  setUp(() {
    networkInformation = MockNetworkInformation();
  });

  group("Test network information's class", () {
    test(
        'Given the instance of NetworkInformation, '
        'When the method of checkInternetConnection was accessed, '
        'Then it should return InternetConnectionStatus.connected '
        'if the internet connection was available.', () async {
      // ARRANGE
      when(() => networkInformation.checkInternetConnection()).thenAnswer(
        (_) => Future<InternetConnectionStatus>.value(
          InternetConnectionStatus.connected,
        ),
      );

      // ACT
      final results = await networkInformation.checkInternetConnection();

      // ASSERT
      expect(results, isA<InternetConnectionStatus>());
      expect(results, equals(InternetConnectionStatus.connected));
      verify(() => networkInformation.checkInternetConnection()).called(1);
    });

    test(
        'Given the instance of NetworkInformation, '
        'When the method of checkInternetConnection was accessed, '
        'Then it should return InternetConnectionStatus.disconnected '
        'if the internet connection was not available.', () async {
      // ARRANGE
      when(() => networkInformation.checkInternetConnection()).thenAnswer(
        (_) => Future<InternetConnectionStatus>.value(
          InternetConnectionStatus.disconnected,
        ),
      );

      // ACT
      final results = await networkInformation.checkInternetConnection();

      // ASSERT
      expect(results, isA<InternetConnectionStatus>());
      expect(results, equals(InternetConnectionStatus.disconnected));
      verify(() => networkInformation.checkInternetConnection()).called(1);
    });

    test(
        'Given the instance of NetworkInformation, '
        'When the method of listenConnectionStatusUpdates was accessed, '
        'Then it should return the Stream value of InternetConnectionStatus.connected.',
        () async {
      // ARRANGE
      when(() => networkInformation.listenConnectionStatusUpdates())
          .thenAnswer((_) => Stream.value(InternetConnectionStatus.connected));

      // ACT
      final streamResults = networkInformation.listenConnectionStatusUpdates();
      final results = await streamResults.first;

      // ASSERT
      expect(streamResults, isA<Stream<InternetConnectionStatus>>());
      expect(results, equals(InternetConnectionStatus.connected));
      verify(() => networkInformation.listenConnectionStatusUpdates())
          .called(1);
    });

    test(
        'Given the instance of NetworkInformation, '
        'When the method of listenConnectionStatusUpdates was accessed, '
        'Then it should return the Stream value of InternetConnectionStatus.disconnected.',
        () async {
      // ARRANGE
      when(() => networkInformation.listenConnectionStatusUpdates()).thenAnswer(
        (_) => Stream.value(InternetConnectionStatus.disconnected),
      );

      // ACT
      final streamResults = networkInformation.listenConnectionStatusUpdates();
      final results = await streamResults.first;

      // ASSERT
      expect(streamResults, isA<Stream<InternetConnectionStatus>>());
      expect(results, equals(InternetConnectionStatus.disconnected));
      verify(() => networkInformation.listenConnectionStatusUpdates())
          .called(1);
    });

    test(
        'Given the instance of NetworkInformation, '
        'When the method of checkAvailableListeners was accessed, '
        'Then it should return the bool value of true '
        "if any listeners was connected into NetworkInformation's Stream.",
        () async {
      // ARRANGE
      when(() => networkInformation.checkAvailableListeners()).thenReturn(true);

      // ACT
      final results = networkInformation.checkAvailableListeners();

      // ASSERT
      expect(results, isA<bool>());
      expect(results, isTrue);
      verify(() => networkInformation.checkAvailableListeners()).called(1);
    });

    test(
        'Given the instance of NetworkInformation, '
        'When the method of checkAvailableListeners was accessed, '
        'Then it should return the bool value of false '
        "if any listeners was not connected into NetworkInformation's Stream.",
        () async {
      // ARRANGE
      when(() => networkInformation.checkAvailableListeners())
          .thenReturn(false);

      // ACT
      final results = networkInformation.checkAvailableListeners();

      // ASSERT
      expect(results, isA<bool>());
      expect(results, isFalse);
      verify(() => networkInformation.checkAvailableListeners()).called(1);
    });
  });
}
