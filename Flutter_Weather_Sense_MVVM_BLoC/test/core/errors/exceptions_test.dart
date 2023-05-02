import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

void main() {
  group("Test server exception's class", () {
    test(
        'Given  the instance of ServerException, '
        'When the instance was available, '
        'Then it should equals with another ServerException instance.',
        () async {
      // ARRANGE

      // ACT
      const instance = ServerException(message: 'Default Message');

      // ASSERT
      expect(instance, isA<ServerException>());
      expect(instance.stringify, equals(isTrue));
      expect(
        instance,
        equals(const ServerException(message: 'Default Message')),
      );
    });

    test(
        'Given  the instance of ServerException, '
        'When the props was not null, '
        'Then it should supports value equality of ServerException props.',
        () async {
      // ARRANGE

      // ACT
      const instance = ServerException(message: 'message');

      // ASSERT
      expect(instance, isA<ServerException>());
      expect(instance.stringify, equals(isTrue));
      expect(instance.props, equals(<Object?>['message']));
    });
  });

  group("Test cache exception's class", () {
    test(
        'Given  the instance of CacheException, '
        'When the instance was available, '
        'Then it should equals with another CacheException instance.',
        () async {
      // ARRANGE

      // ACT
      const instance = CacheException(message: 'Default Message');

      // ASSERT
      expect(instance, isA<CacheException>());
      expect(instance.stringify, equals(isTrue));
      expect(
        instance,
        equals(const CacheException(message: 'Default Message')),
      );
    });

    test(
        'Given  the instance of CacheException, '
        'When the props was not null, '
        'Then it should supports value equality of CacheException props.',
        () async {
      // ARRANGE

      // ACT
      const instance = CacheException(message: 'message');

      // ASSERT
      expect(instance, isA<CacheException>());
      expect(instance.stringify, equals(isTrue));
      expect(instance.props, equals(<Object?>['message']));
    });
  });

  group("Test unexpected exception's class", () {
    test(
        'Given  the instance of UnexpectedException, '
        'When the instance was available, '
        'Then it should equals with another UnexpectedException instance.',
        () async {
      // ARRANGE

      // ACT
      const instance = UnexpectedException(message: 'Default Message');

      // ASSERT
      expect(instance, isA<UnexpectedException>());
      expect(instance.stringify, equals(isTrue));
      expect(
        instance,
        equals(const UnexpectedException(message: 'Default Message')),
      );
    });

    test(
        'Given  the instance of UnexpectedException, '
        'When the props was not null, '
        'Then it should supports value equality of UnexpectedException props.',
        () async {
      // ARRANGE

      // ACT
      const instance = UnexpectedException(message: 'message');

      // ASSERT
      expect(instance, isA<UnexpectedException>());
      expect(instance.stringify, equals(isTrue));
      expect(instance.props, equals(<Object?>['message']));
    });
  });
}
