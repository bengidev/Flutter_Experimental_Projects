import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
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
          hourlyWeatherForecastModel: null,
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
          hourlyWeatherForecastModel: mockHourlyWeatherForecastModel(),
          failureMessage: mockServerFailureMessage(),
        ),
        equals(
          HomeState(
            status: HomeBlocStatus.success,
            forwardGeocodingModel: mockForwardGeocodingModel(),
            hourlyWeatherForecastModel: mockHourlyWeatherForecastModel(),
            failureMessage: mockServerFailureMessage(),
          ),
        ),
      );
    });
  });
}
