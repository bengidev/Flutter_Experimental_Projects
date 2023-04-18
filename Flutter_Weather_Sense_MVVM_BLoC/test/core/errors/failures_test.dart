import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

void main() {
  group("Test server failure's class ", () {
    test(
        'Given the instance of ServerFailure, '
        'When the instance was available, '
        'Then it should supports value equality of ServerFailure props.',
        () async {
      // ARRANGE

      // ACT
      final instance = ServerFailure();

      // ASSERT
      expect(instance, isA<Failure>());
      expect(instance.props, equals(<Object?>[]));
    });
  });

  group("Test cache failure's class ", () {
    test(
        'Given the instance of CacheFailure, '
        'When the instance was available, '
        'Then it should supports value equality of CacheFailure props.',
        () async {
      // ARRANGE

      // ACT
      final instance = CacheFailure();

      // ASSERT
      expect(instance, isA<Failure>());
      expect(instance.props, equals(<Object?>[]));
    });
  });

  group("Test invalid input failure's class ", () {
    test(
        'Given the instance of InvalidInputFailure, '
        'When the instance was available, '
        'Then it should supports value equality of InvalidInputFailure props.',
        () async {
      // ARRANGE

      // ACT
      final instance = InvalidInputFailure();

      // ASSERT
      expect(instance, isA<Failure>());
      expect(instance.props, equals(<Object?>[]));
    });
  });

  group("Test unexpected failure's class ", () {
    test(
        'Given the instance of UnexpectedFailure, '
        'When the instance was available, '
        'Then it should supports value equality of UnexpectedFailure props.',
        () async {
      // ARRANGE

      // ACT
      final instance = UnexpectedFailure();

      // ASSERT
      expect(instance, isA<Failure>());
      expect(instance.props, equals(<Object?>[]));
    });
  });
}
