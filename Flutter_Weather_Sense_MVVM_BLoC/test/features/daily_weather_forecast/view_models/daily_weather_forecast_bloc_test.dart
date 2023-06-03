import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model/daily_weather_forecast_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/usecases/find_daily_weather_forecast_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/view_models/daily_weather_forecast_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockFindDailyWeatherForecastCase extends Mock
    implements FindDailyWeatherForecastCase {}

void main() async {
  late FindDailyWeatherForecastCase findDailyWeatherForecastCase;

  setUp(() {
    findDailyWeatherForecastCase = MockFindDailyWeatherForecastCase();
  });

  DailyWeatherForecastModel buildDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  double buildLatitudeCoordinate() => 52.52;

  double buildLongitudeCoordinate() => 13.419998;

  DailyWeatherForecastBloc
      buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase() {
    return DailyWeatherForecastBloc(
      findDailyWeatherForecastCase: findDailyWeatherForecastCase,
    );
  }

  DailyWeatherForecastBloc buildDailyWeatherForecastBlocWithEmptyConstructor() {
    return DailyWeatherForecastBloc();
  }

  DailyWeatherForecastModel mockDailyWeatherForecastModel() {
    return DailyWeatherForecastModel.defaultValue();
  }

  group('Testing DailyWeatherForecastBloc', () {
    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When its constructor has no errors, '
        'Then it should works properly.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase,
        returnsNormally,
      );
    });

    test(
        'Given the instance of DailyWeatherForecastBloc, '
        'When its constructor has no errors, '
        'Then its initial state should correct.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase().state,
        equals(const DailyWeatherForecastState()),
      );
    });

    blocTest<DailyWeatherForecastBloc, DailyWeatherForecastState>(
      'Given the instance of DailyWeatherForecastBloc, '
      'When the DailyWeatherForecastBloc Constructor was empty, '
      'Then it should return null or empty value.',
      build: buildDailyWeatherForecastBlocWithEmptyConstructor,
      setUp: () {},
      act: (bloc) {},
      expect: () => [],
    );
  });

  group("Testing to add the FindDailyWeatherForecastEvent", () {
    blocTest<DailyWeatherForecastBloc, DailyWeatherForecastState>(
      'Given the instance of DailyWeatherForecastBloc, '
      'When the FindDailyWeatherForecastEvent was added, '
      'Then it should return the right of DailyWeatherForecastState with success status.',
      build: buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase,
      setUp: () {
        when(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        ).thenAnswer((_) async => Right(buildDailyWeatherForecastModel()));
      },
      act: (bloc) {
        bloc.add(
          FindDailyWeatherForecastEvent(
            latitude: buildLatitudeCoordinate(),
            longitude: buildLongitudeCoordinate(),
          ),
        );
      },
      expect: () => [
        const DailyWeatherForecastState(
          status: DailyWeatherForecastBlocStatus.loading,
        ),
        DailyWeatherForecastState(
          status: DailyWeatherForecastBlocStatus.success,
          dailyWeatherForecastModel: buildDailyWeatherForecastModel(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        );
      },
    );

    blocTest<DailyWeatherForecastBloc, DailyWeatherForecastState>(
      'Given the instance of DailyWeatherForecastBloc, '
      'When the FindDailyWeatherForecastEvent was added, '
      'Then it should return the left of ServerFailure '
      'with the server exception status.',
      build: buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase,
      setUp: () {
        when(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (bloc) {
        bloc.add(
          FindDailyWeatherForecastEvent(
            latitude: buildLatitudeCoordinate(),
            longitude: buildLongitudeCoordinate(),
          ),
        );
      },
      expect: () => [
        const DailyWeatherForecastState(
            status: DailyWeatherForecastBlocStatus.loading),
        DailyWeatherForecastState(
          status: DailyWeatherForecastBlocStatus.failure,
          failureMessage: ServerFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        );
      },
    );

    blocTest<DailyWeatherForecastBloc, DailyWeatherForecastState>(
      'Given the instance of DailyWeatherForecastBloc, '
      'When the FindDailyWeatherForecastEvent was added, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildDailyWeatherForecastBlocWithFindDailyWeatherForecastCase,
      setUp: () {
        when(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        ).thenAnswer((_) async => Left(UnexpectedFailure()));
      },
      act: (bloc) {
        bloc.add(
          FindDailyWeatherForecastEvent(
            latitude: buildLatitudeCoordinate(),
            longitude: buildLongitudeCoordinate(),
          ),
        );
      },
      expect: () => [
        const DailyWeatherForecastState(
            status: DailyWeatherForecastBlocStatus.loading),
        DailyWeatherForecastState(
          status: DailyWeatherForecastBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findDailyWeatherForecastCase(
            DailyWeatherForecastParameter(
              latitude: buildLatitudeCoordinate(),
              longitude: buildLongitudeCoordinate(),
            ),
          ),
        );
      },
    );

    blocTest<DailyWeatherForecastBloc, DailyWeatherForecastState>(
      'Given the instance of DailyWeatherForecastBloc, '
      'When the FindDailyWeatherForecastEvent was null, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildDailyWeatherForecastBlocWithEmptyConstructor,
      setUp: () {},
      act: (bloc) {
        bloc.add(
          FindDailyWeatherForecastEvent(
            latitude: buildLatitudeCoordinate(),
            longitude: buildLongitudeCoordinate(),
          ),
        );
      },
      expect: () => [
        const DailyWeatherForecastState(
            status: DailyWeatherForecastBlocStatus.loading),
        DailyWeatherForecastState(
          status: DailyWeatherForecastBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {},
    );
  });
}
