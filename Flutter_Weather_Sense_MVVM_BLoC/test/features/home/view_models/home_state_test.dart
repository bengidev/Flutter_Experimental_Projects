import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';

void main() async {
  ForwardGeocodingModel mockForwardGeocodingModel() {
    return const ForwardGeocodingModel(
      type: '',
      queries: <String>[],
      features: <ForwardFeature>[],
      attribution: '',
    );
  }

  String mockServerFailureMessage() => "Server Failure";
  String mockUnexpectedFailureMessage() => "Unexpected Failure";

  group('Testing Home State', () {
    test(
        'Given the instance of Home Bloc, '
        'When the instance of its state was available, '
        'Then it should supports value equality of the state itself.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const HomeState(),
        equals(const HomeState()),
      );
    });

    test(
        'Given the instance of Home Bloc, '
        'When the instance of its state was available, '
        'Then it should correct the value of copyWith.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const HomeState().copyWith(),
        equals(const HomeState()),
      );
    });

    test(
        'Given the instance of Home Bloc, '
        'When the instance of its state was available, '
        'Then it should retains the old value for every parameter if null is provided.',
        () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const HomeState().copyWith(
          status: null,
          forwardGeocodingModel: null,
          failureMessage: null,
        ),
        equals(const HomeState()),
      );
    });

    test(
        'Given the instance of Home Bloc, '
        'When the instance of its state was available, '
        'Then it should replaces every non-null parameter.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        const HomeState().copyWith(
          status: HomeBlocStatus.success,
          forwardGeocodingModel: mockForwardGeocodingModel(),
          failureMessage: mockServerFailureMessage(),
        ),
        equals(
          HomeState(
            status: HomeBlocStatus.success,
            forwardGeocodingModel: mockForwardGeocodingModel(),
            failureMessage: mockServerFailureMessage(),
          ),
        ),
      );
    });
  });
}
