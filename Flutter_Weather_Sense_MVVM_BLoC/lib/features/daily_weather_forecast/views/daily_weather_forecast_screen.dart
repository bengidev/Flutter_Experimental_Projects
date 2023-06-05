import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/models/daily_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/view_models/daily_weather_forecast_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/daily_weather_forecast/views/daily_views_barrel.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DailyWeatherForecastScreen extends HookWidget {
  const DailyWeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localStateLatitudeCoordinate = useState<double>(0.0);
    final localStateLongitudeCoordinate = useState<double>(0.0);
    final localStateDailyWeatherForecastModel =
        useState<DailyWeatherForecastModel>(
      DailyWeatherForecastModel.defaultValue(),
    );
    final localStateDailyWeather = useState<DailyWeather>(
      DailyWeather.defaultValue(),
    );
    final localStateForecastAvailableDays = useState<List<String>>(<String>[]);
    final localStateSelectedDayIndex = useState<int>(0);

    /// Useful for side-effects and optionally canceling them.
    /// useEffect is called synchronously on every build, unless keys is specified.
    /// In which case useEffect is called again only,
    /// if any value inside keys as changed.
    useEffect(
      () {
        // Start the following events when the widget is first rendered.
        Future.microtask(() async {
          localStateLatitudeCoordinate.value = _loadLatestLatitudeCoordinate();
          localStateLongitudeCoordinate.value =
              _loadLatestLongitudeCoordinate();

          debugPrint("Microtask from UseEffect: Called!");
          debugPrint("Latitude -> ${localStateLatitudeCoordinate.value}");
          debugPrint("Longitude -> ${localStateLongitudeCoordinate.value}");
        });

        // We could optionally return some "dispose" logic here.
        // We can return more than one disposing event by
        // returning a void Function, like return () {}.
        return null;
      },
      // Tell Flutter to rebuild this widget when
      // the values inside the bracket updates.
      [
        localStateLatitudeCoordinate,
        localStateLongitudeCoordinate,
        localStateDailyWeatherForecastModel,
        localStateDailyWeather,
        localStateForecastAvailableDays,
        localStateSelectedDayIndex,
      ],
    );

    return BlocProvider(
      create: (context) => $serviceLocator.get<DailyWeatherForecastBloc>(),
      child: Scaffold(
        body: SafeArea(
          child:
              BlocConsumer<DailyWeatherForecastBloc, DailyWeatherForecastState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                debugPrint("DailyWeatherForecastState -> ${state.status}");
                final extractedDailyWeatherForecastModel =
                    _extractDailyWeatherForecastModel(
                  state: state,
                );

                _saveDailyWeatherForecastModelToLocalState(
                  dailyWeatherForecastModel: extractedDailyWeatherForecastModel,
                  valueNotifier: localStateDailyWeatherForecastModel,
                );

                final extractedAvailableDaysForecast =
                    _extractForecastAvailableDaysFromDailyWeatherForecastModel(
                  dailyWeatherForecastModel:
                      localStateDailyWeatherForecastModel.value,
                );

                _saveForecastAvailableDaysToLocalState(
                  forecastAvailableDays: extractedAvailableDaysForecast,
                  valueNotifier: localStateForecastAvailableDays,
                );

                final extractedDailyWeatherStatus =
                    _extractDailyWeatherStatusFromDailyWeatherForecastModel(
                  dailyWeatherForecastModel:
                      localStateDailyWeatherForecastModel.value,
                );

                _saveDailyWeatherStatusToLocalState(
                  dailyWeather: extractedDailyWeatherStatus,
                  valueNotifier: localStateDailyWeather,
                );

                debugPrint(
                  "Daily Weather Forecast -> ${localStateDailyWeatherForecastModel.value}",
                );
                debugPrint(
                  "Available Days Weather Forecast -> ${localStateForecastAvailableDays.value}",
                );
                debugPrint(
                  "Extracted Daily Weather Status -> $extractedDailyWeatherStatus",
                );
              }
            },
            builder: (context, state) {
              if (state.status.isInitial) {
                return VisibilityDetector(
                  key: const ValueKey("DAILY_WEATHER_FORECAST_SCREEN_KEY"),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0) {
                      _dispatchFindDailyWeatherForecastEvent(
                        context: context,
                        latitude: localStateLatitudeCoordinate.value,
                        longitude: localStateLongitudeCoordinate.value,
                      );
                    }
                  },
                );
              } else if (state.status.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Daily Weather Forecast Header
                    const DailyHeader(),
                    Gap($styles.insets.sm),

                    // Daily Weather Forecast Body
                    DailyAvailableDays(
                      availableDays: localStateForecastAvailableDays.value,
                      selectedDayIndex: localStateSelectedDayIndex.value,
                      onDayPressed: (index) async {
                        debugPrint("index -> $index");
                        localStateSelectedDayIndex.value = index;
                      },
                    ),

                    // Daily Weather Forecast Body
                    DailyWeatherCard(
                      weatherImage: _extractWeatherImageFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        dayDescription: _extractDayDescriptionFromDailyWeather(
                          dailyWeather: localStateDailyWeather.value,
                          index: localStateSelectedDayIndex.value,
                        ),
                        index: localStateSelectedDayIndex.value,
                      ),
                      weatherDescription:
                          _extractWeatherDescriptionFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                      temperatureMax:
                          _extractMaxWeatherTemperatureFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                      temperatureMin:
                          _extractMinWeatherTemperatureFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                      windSpeed: _extractWeatherWindSpeedFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                      precipitationProbability:
                          _extractWeatherPrecipitationProbabilityFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                    ),

                    // Daily Weather Forecast Footer
                    DailySunCard(
                      sunriseTime: _extractWeatherSunriseTimeFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                      sunsetTime: _extractWeatherSunsetTimeFromDailyWeather(
                        dailyWeather: localStateDailyWeather.value,
                        index: localStateSelectedDayIndex.value,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Load the [latitude] coordinate's latest saved value from
  /// [SharedPreferencesStorage] when the latest saved
  /// latitude coordinate's value was available.
  ///
  /// This will return the default [double] value when
  /// the latest saved latitude coordinate's value was empty.
  ///
  double _loadLatestLatitudeCoordinate() {
    final latestLatitude =
        SharedPreferencesStorage.getLatestLatitudeCoordinate();
    return latestLatitude;
  }

  /// Load the [longitude] coordinate's latest saved value from
  /// [SharedPreferencesStorage] when the latest saved
  /// longitude coordinate's value was available.
  ///
  /// This will return the default [double] value when
  /// the latest saved longitude coordinate's value was empty.
  ///
  double _loadLatestLongitudeCoordinate() {
    final latestLongitude =
        SharedPreferencesStorage.getLatestLongitudeCoordinate();
    return latestLongitude;
  }

  /// Send the [FindDailyWeatherForecastEvent] into the
  /// [DailyWeatherForecastBloc] by providing the [context] with
  /// [latitude] and [longitude] coordinates
  /// parameters.
  void _dispatchFindDailyWeatherForecastEvent({
    required BuildContext context,
    required double latitude,
    required double longitude,
  }) {
    context.read<DailyWeatherForecastBloc>().add(
          FindDailyWeatherForecastEvent(
            latitude: latitude,
            longitude: longitude,
          ),
        );
  }

  /// Extract the results from the [DailyWeatherForecastBloc]'s state
  /// based on each [DailyWeatherForecastState]'s returned values.
  ///
  /// This will return the [DailyWeatherForecastModel] when
  /// the results from [DailyWeatherForecastBloc]'s state was
  /// successful and not null.
  ///
  /// This will return empty or null
  /// when the returned [DailyWeatherForecastState]'s values are
  /// unknown or undefined.
  ///
  DailyWeatherForecastModel? _extractDailyWeatherForecastModel({
    required DailyWeatherForecastState state,
  }) {
    if (state.status == DailyWeatherForecastBlocStatus.success) {
      final dailyWeatherForecast = state.dailyWeatherForecastModel;

      if (dailyWeatherForecast != null) {
        return dailyWeatherForecast;
      }
    }

    return null;
  }

  /// Save the [DailyWeatherForecastModel] to the
  /// local state using [valueNotifier] only when
  /// the [DailyWeatherForecastModel]'s value is not null.
  ///
  void _saveDailyWeatherForecastModelToLocalState({
    required DailyWeatherForecastModel? dailyWeatherForecastModel,
    required ValueNotifier<DailyWeatherForecastModel> valueNotifier,
  }) {
    if (dailyWeatherForecastModel != null) {
      valueNotifier.value = dailyWeatherForecastModel;
    }
  }

  /// Extract the available days' value from [DailyWeatherForecastModel]
  /// to perform forecasting weather with the selected day.
  ///
  List<String> _extractForecastAvailableDaysFromDailyWeatherForecastModel({
    required DailyWeatherForecastModel dailyWeatherForecastModel,
  }) {
    final extractedDailyWeather = dailyWeatherForecastModel.dailyWeather;
    return extractedDailyWeather.time;
  }

  /// Save the [forecastAvailableDays] to the
  /// local state using [valueNotifier] only when
  /// the [forecastAvailableDays]'s value is not empty.
  ///
  void _saveForecastAvailableDaysToLocalState({
    required List<String> forecastAvailableDays,
    required ValueNotifier<List<String>> valueNotifier,
  }) {
    if (forecastAvailableDays.isNotEmpty) {
      valueNotifier.value = forecastAvailableDays;
    }
  }

  /// Extract the [DailyWeather]'s value from [DailyWeatherForecastModel]
  /// for showing the [DailyWeather]'s status results.
  ///
  DailyWeather _extractDailyWeatherStatusFromDailyWeatherForecastModel({
    required DailyWeatherForecastModel dailyWeatherForecastModel,
  }) {
    return dailyWeatherForecastModel.dailyWeather;
  }

  /// Save the [dailyWeather] to the local state using [valueNotifier].
  ///
  void _saveDailyWeatherStatusToLocalState({
    required DailyWeather dailyWeather,
    required ValueNotifier<DailyWeather> valueNotifier,
  }) {
    valueNotifier.value = dailyWeather;
  }

  /// Extract the [String] of [DailyWeather]'s
  /// code value from [DailyWeather] with
  /// the specified [index].
  ///
  String _extractWeatherImageFromDailyWeather({
    required DailyWeather dailyWeather,
    required String dayDescription,
    required int index,
  }) {
    final weatherCodes = dailyWeather.weatherCode;
    final singleWeatherCode = weatherCodes.elementAt(index);
    final generatedImage = WeatherForecastHelper.generateWeatherImage(
      weatherCode: singleWeatherCode,
      dayDescription: dayDescription,
    );
    return generatedImage;
  }

  /// Extract the day description value from [DailyWeather] with
  /// the specified [index].
  ///
  String _extractDayDescriptionFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherTimes = dailyWeather.time;
    final singleWeatherTime = weatherTimes.elementAt(index);
    final parsedWeatherTime = DateTime.parse(singleWeatherTime);
    final generatedDayDescription = GreetingOfDay.getFromTime(
      time: parsedWeatherTime,
      hasClockTime: false,
    );
    return generatedDayDescription;
  }

  /// Extract the weather description from [DailyWeather] with
  /// the specified [index].
  ///
  String _extractWeatherDescriptionFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherCodes = dailyWeather.weatherCode;
    final singleWeatherCode = weatherCodes.elementAt(index);
    final generatedDescription =
        WeatherForecastHelper.generateWeatherDescription(
      weatherCode: singleWeatherCode,
    );
    return generatedDescription;
  }

  /// Extract the maximum weather temperature from [DailyWeather]
  /// with the specified [index].
  ///
  double _extractMaxWeatherTemperatureFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final maxWeatherTemperatures = dailyWeather.temperature2MMax;
    final singleMaxTemperature = maxWeatherTemperatures.elementAt(index);
    return singleMaxTemperature;
  }

  /// Extract the minimum weather temperature from [DailyWeather]
  /// with the specified [index].
  ///
  double _extractMinWeatherTemperatureFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final minWeatherTemperatures = dailyWeather.temperature2MMin;
    final singleMinTemperature = minWeatherTemperatures.elementAt(index);
    return singleMinTemperature;
  }

  /// Extract the weather wind speed from [DailyWeather]
  /// with the specified [index].
  ///
  double _extractWeatherWindSpeedFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherWindSpeeds = dailyWeather.windSpeed10MMax;
    final singleWindSpeed = weatherWindSpeeds.elementAt(index);
    return singleWindSpeed;
  }

  /// Extract the weather precipitation probability from [DailyWeather]
  /// with the specified [index].
  ///
  int _extractWeatherPrecipitationProbabilityFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherPrecipitationProbabilities =
        dailyWeather.precipitationProbabilityMax;
    final singlePrecipitationProbability =
        weatherPrecipitationProbabilities.elementAt(index);
    return singlePrecipitationProbability;
  }

  /// Extract the weather sunrise time from [DailyWeather]
  /// with the specified [index].
  ///
  String _extractWeatherSunriseTimeFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherSunriseTimes = dailyWeather.sunrise;
    final singleSunriseTime = weatherSunriseTimes.elementAt(index);
    final splittedSunriseTime = singleSunriseTime.split("T");
    final formattedSunriseTime = splittedSunriseTime.last;
    return formattedSunriseTime;
  }

  /// Extract the weather sunset time from [DailyWeather]
  /// with the specified [index].
  ///
  String _extractWeatherSunsetTimeFromDailyWeather({
    required DailyWeather dailyWeather,
    required int index,
  }) {
    final weatherSunsetTimes = dailyWeather.sunset;
    final singleSunsetTime = weatherSunsetTimes.elementAt(index);
    final splittedSunsetTime = singleSunsetTime.split("T");
    final formattedSunsetTime = splittedSunsetTime.last;
    return formattedSunsetTime;
  }
}
