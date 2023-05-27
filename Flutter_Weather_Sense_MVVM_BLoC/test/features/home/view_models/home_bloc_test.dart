import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_current_weather.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model/hourly_next_weather.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/find_hourly_weather_forecast_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/usecases/search_location_case.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchLocationCase extends Mock implements SearchLocationCase {}

class MockFindHourlyWeatherForecastCase extends Mock
    implements FindHourlyWeatherForecastCase {}

void main() async {
  late MockSearchLocationCase searchLocationCase;
  late MockFindHourlyWeatherForecastCase findHourlyWeatherForecastCase;

  setUp(() {
    searchLocationCase = MockSearchLocationCase();
    findHourlyWeatherForecastCase = MockFindHourlyWeatherForecastCase();
  });

  HomeBloc buildHomeBlocWithSearchLocationCase() {
    return HomeBloc(searchLocationCase: searchLocationCase);
  }

  HomeBloc buildHomeBlocWithFindHourlyWeatherForecastCase() {
    return HomeBloc(
      findHourlyWeatherForecastCase: findHourlyWeatherForecastCase,
    );
  }

  HomeBloc buildHomeBlocWithEmptyConstructor() {
    return HomeBloc();
  }

  ForwardGeocodingModel mockForwardGeocodingModel() {
    return const ForwardGeocodingModel(
      type: '',
      queries: <String>[],
      features: <ForwardFeature>[],
      attribution: '',
    );
  }

  HourlyWeatherForecastModel mockHourlyWeatherForecastModel() {
    return const HourlyWeatherForecastModel(
      latitude: 0,
      longitude: 0,
      elevation: 0,
      generationTimeMs: 0,
      hourlyCurrentWeather: HourlyCurrentWeather(
        temperature: 0,
        windSpeed: 0,
        windDirection: 0,
        weatherCode: 0,
        isDay: 0,
        time: "",
      ),
      hourlyNextWeather: HourlyNextWeather(
        time: <String>[],
        temperature2M: <double>[],
        relativeHumidity2M: <int>[],
        dewPoint2M: <double>[],
        apparentTemperature: <double>[],
        precipitationProbability: <int>[],
        weatherCode: <int>[],
        surfacePressure: <double>[],
        visibility: <double>[],
        windSpeed10M: <double>[],
      ),
      hourlyWeatherUnits: HourlyWeatherUnits(
        time: "",
        temperature2M: "",
        relativeHumidity2M: "",
        dewPoint2M: "",
        apparentTemperature: "",
        precipitationProbability: "",
        weatherCode: "",
        surfacePressure: "",
        visibility: "",
        windSpeed10M: "",
      ),
      timezone: "",
      timezoneAbbreviation: "",
      utcOffsetSeconds: 0,
    );
  }

  group('Testing HomeBloc constructor', () {
    test(
        'Given the instance of HomeBloc, '
        'When its constructor has no errors, '
        'Then it should works properly.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(buildHomeBlocWithSearchLocationCase, returnsNormally);
    });

    test(
        'Given the instance of HomeBloc, '
        'When its constructor has no errors, '
        'Then its initial state should correct.', () async {
      // ARRANGE

      // ACT

      // ASSERT
      expect(
        buildHomeBlocWithSearchLocationCase().state,
        equals(const HomeState()),
      );
    });

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the HomeBloc Constructor was empty, '
      'Then it should return null or empty value.',
      build: buildHomeBlocWithEmptyConstructor,
      setUp: () {},
      act: (bloc) {},
      expect: () => [],
    );
  });

  group("Testing to add the SearchGeocodingLocationEvent", () {
    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the right of HomeState with success status.',
      build: buildHomeBlocWithSearchLocationCase,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Right(mockForwardGeocodingModel()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.success,
          forwardGeocodingModel: mockForwardGeocodingModel(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the left of ServerFailure '
      'with the server exception status.',
      build: buildHomeBlocWithSearchLocationCase,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: ServerFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was added, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildHomeBlocWithSearchLocationCase,
      setUp: () {
        when(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        ).thenAnswer((_) async => Left(UnexpectedFailure()));
      },
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => searchLocationCase(
            const SearchInputParameter(location: 'pontianak'),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the SearchGeocodingLocationEvent was null, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildHomeBlocWithEmptyConstructor,
      setUp: () {},
      act: (bloc) {
        bloc.add(const SearchGeocodingLocationEvent(location: 'pontianak'));
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {},
    );
  });

  group("Testing to add the FindHourlyWeatherForecastEvent", () {
    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the FindHourlyWeatherForecastEvent was added, '
      'Then it should return the right of HomeState with success status.',
      build: buildHomeBlocWithFindHourlyWeatherForecastCase,
      setUp: () {
        when(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(
              latitude: 0,
              longitude: 0,
            ),
          ),
        ).thenAnswer((_) async => Right(mockHourlyWeatherForecastModel()));
      },
      act: (bloc) {
        bloc.add(
          const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0),
        );
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.success,
          hourlyWeatherForecastModel: mockHourlyWeatherForecastModel(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(
              latitude: 0,
              longitude: 0,
            ),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the FindHourlyWeatherForecastEvent was added, '
      'Then it should return the left of ServerFailure '
      'with the server exception status.',
      build: buildHomeBlocWithFindHourlyWeatherForecastCase,
      setUp: () {
        when(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(
              latitude: 0,
              longitude: 0,
            ),
          ),
        ).thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (bloc) {
        bloc.add(
          const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0),
        );
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: ServerFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(latitude: 0, longitude: 0),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the FindHourlyWeatherForecastEvent was added, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildHomeBlocWithFindHourlyWeatherForecastCase,
      setUp: () {
        when(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(latitude: 0, longitude: 0),
          ),
        ).thenAnswer((_) async => Left(UnexpectedFailure()));
      },
      act: (bloc) {
        bloc.add(
          const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0),
        );
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {
        verify(
          () => findHourlyWeatherForecastCase(
            const HourlyWeatherForecastParameter(latitude: 0, longitude: 0),
          ),
        );
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Given the instance of HomeBloc, '
      'When the FindHourlyWeatherForecastEvent was null, '
      'Then it should return the left of UnexpectedFailure '
      'with the unexpected exception status.',
      build: buildHomeBlocWithEmptyConstructor,
      setUp: () {},
      act: (bloc) {
        bloc.add(
          const FindHourlyWeatherForecastEvent(latitude: 0, longitude: 0),
        );
      },
      expect: () => [
        const HomeState(status: HomeBlocStatus.loading),
        HomeState(
          status: HomeBlocStatus.failure,
          failureMessage: UnexpectedFailure().toString(),
        ),
      ],
      verify: (bloc) {},
    );
  });
}
