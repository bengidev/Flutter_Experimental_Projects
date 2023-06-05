import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/hourly_weather_forecast_model_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_views_barrel.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dayDescription = useState<String>("Hallo, ");
    final firstFocusNode = useFocusNode();
    final firstTextEditingController = useTextEditingController();
    final cacheSelectedIndexState = useState<int>(0);
    final cacheLatitudeCoordinate = useState<double>(0.0);
    final cacheLongitudeCoordinate = useState<double>(0.0);
    final cacheHourlyWeatherForecastModel =
        useState<HourlyWeatherForecastModel>(
      HourlyWeatherForecastModel.defaultValue(),
    );
    final cacheHourlyCurrentWeather = useState<HourlyCurrentWeather>(
      HourlyCurrentWeather.defaultValue(),
    );

    /// Useful for side-effects and optionally canceling them.
    /// useEffect is called synchronously on every build, unless keys is specified.
    /// In which case useEffect is called again only,
    /// if any value inside keys as changed.
    useEffect(
      () {
        // Start the following events when the widget is first rendered.
        Future.microtask(() async {
          dayDescription.value = _generateGreetingDay(
            time: DateTime.now(),
          );

          cacheLatitudeCoordinate.value = _loadModelFeatureLatitude();
          cacheLongitudeCoordinate.value = _loadModelFeatureLongitude();

          await _saveLatestLatitudeCoordinate(
            latitude: cacheLatitudeCoordinate.value,
          );
          await _saveLatestLongitudeCoordinate(
            longitude: cacheLongitudeCoordinate.value,
          );

          cacheHourlyWeatherForecastModel.value =
              _loadHourlyWeatherForecastModel();

          cacheHourlyCurrentWeather.value = _loadHourlyCurrentWeather();

          debugPrint("Microtask from UseEffect: $dayDescription");
        });

        // We could optionally return some "dispose" logic here.
        // We can return more than one disposing event by
        // returning a void Function, like return () {}.
        return null;
      },
      // Tell Flutter to rebuild this widget when
      // the values inside the bracket updates.
      [
        dayDescription,
        firstFocusNode,
        firstTextEditingController,
        cacheLatitudeCoordinate,
        cacheLongitudeCoordinate,
        cacheHourlyWeatherForecastModel,
        cacheHourlyCurrentWeather,
      ],
    );

    return BlocProvider(
      create: (context) => $serviceLocator.get<HomeBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) async {
              debugPrint("Home State -> $state");

              if (state.status == HomeBlocStatus.success) {
                // Save the [extractedModelFeature]'s value when
                // the value was not empty.
                final extractedModelFeature = _extractModelFeature(
                  state: state,
                  index: cacheSelectedIndexState.value,
                );
                if (extractedModelFeature != null) {
                  cacheLatitudeCoordinate.value =
                      extractedModelFeature.center.last;
                  cacheLongitudeCoordinate.value =
                      extractedModelFeature.center.first;

                  await _saveModelFeatureIntoSharedPreferences(
                    modelFeature: extractedModelFeature,
                  );
                }

                // Save the [extractedHourlyWeatherForecastModel]'s value
                // when the value was not empty.
                final extractedHourlyWeatherForecastModel =
                    _extractHourlyWeatherForecastModel(state: state);

                if (extractedHourlyWeatherForecastModel != null) {
                  cacheHourlyWeatherForecastModel.value =
                      extractedHourlyWeatherForecastModel;

                  await _saveHourlyWeatherForecastModelIntoSharedPreferences(
                    hourlyWeatherForecastModel:
                        extractedHourlyWeatherForecastModel,
                  );
                }

                final extractedCurrentWeatherForecast =
                    _extractCurrentWeatherForecast(state: state);

                if (extractedCurrentWeatherForecast != null) {
                  cacheHourlyCurrentWeather.value =
                      extractedCurrentWeatherForecast;

                  await _saveHourlyCurrentWeatherIntoSharedPreferences(
                    hourlyCurrentWeather: extractedCurrentWeatherForecast,
                  );
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Header Section
                    HomeGreetingDescription(
                      greetingMessage: dayDescription.value,
                    ),
                    Gap($styles.insets.xs),

                    // Header Section
                    AppRawAutoCompleteField(
                      key: const ValueKey('FIRST_APP_TEXT_FORM_FIELD'),
                      focusNode: firstFocusNode,
                      textEditingController: firstTextEditingController,
                      objects: _extractAutoCompleteObjects(state: state),
                      onButtonPressed: (resultText, index) async {
                        // Send the [resultText] into the [HomeBloc]'s event.
                        _dispatchSearchLocationEvent(
                          context: context,
                          location: resultText,
                        );
                      },
                      onOptionPressed: (index) async {
                        debugPrint("onOptionPressed: Pressed");

                        cacheSelectedIndexState.value = index;
                        debugPrint(
                          "cacheSelectedIndexState -> ${cacheSelectedIndexState.value}",
                        );

                        // Send the FindHourlyWeatherForecastEvent into
                        // the HomeBLoc.
                        _dispatchFindHourlyWeatherForecastEvent(
                          context: context,
                          latitude: cacheLatitudeCoordinate.value,
                          longitude: cacheLongitudeCoordinate.value,
                        );
                      },
                    ),

                    Gap($styles.insets.sm),
                    // Body Section
                    HomeLocationMap(
                      locationTitle: LocationDetailHelper.buildLocationTitle(
                        objectString: _loadModelFeaturePlaceName(),
                      ),
                      locationSubTitle:
                          LocationDetailHelper.buildLocationSubTitle(
                        objectString: _loadModelFeaturePlaceName(),
                      ),
                      latitude: cacheLatitudeCoordinate.value,
                      longitude: cacheLongitudeCoordinate.value,
                    ),
                    Gap($styles.insets.sm),

                    // Body Section
                    HomeCurrentWeatherForecastCard(
                      temperatureInCelsius: _extractWeatherTemperatureInCelsius(
                        hourlyCurrentWeather: cacheHourlyCurrentWeather.value,
                      ),
                      weatherImage: _extractWeatherImage(
                        hourlyCurrentWeather: cacheHourlyCurrentWeather.value,
                        dayDescription: dayDescription.value,
                      ),
                      humidity: _extractWeatherHumidity(
                        hourlyWeatherForecastModel:
                            cacheHourlyWeatherForecastModel.value,
                      ),
                      precipitation: _extractWeatherPrecipitationPercentage(
                        hourlyWeatherForecastModel:
                            cacheHourlyWeatherForecastModel.value,
                      ),
                      pressure: _extractWeatherPressure(
                        hourlyWeatherForecastModel:
                            cacheHourlyWeatherForecastModel.value,
                      ),
                      windSpeed: _extractWeatherWindSpeed(
                        hourlyCurrentWeather: cacheHourlyCurrentWeather.value,
                      ),
                    ),
                    Gap($styles.insets.xl),

                    // Body Section
                    const HomeHourlyWeatherForecastTitle(),
                    Gap($styles.insets.sm),

                    // Footer Section
                    HomeHourlyWeatherForecastCard(
                      hourlyWeatherForecastModel:
                          cacheHourlyWeatherForecastModel.value,
                      dayDescription: dayDescription.value,
                    ),
                    Gap($styles.insets.sm),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Generate the [String] of Greeting Day using
  /// the static method [GreetingOfDay.getFromTime].
  /// It will return the [String]
  /// based on the current [DateTime].
  String _generateGreetingDay({
    required DateTime time,
  }) {
    final greetingResults = GreetingOfDay.getFromTime(time: time);
    return greetingResults;
  }

  /// Send the [SearchGeocodingLocationEvent] into the
  /// [HomeBloc] by providing the [context] and [location]
  /// parameters.
  void _dispatchSearchLocationEvent({
    required BuildContext context,
    required String location,
  }) {
    context
        .read<HomeBloc>()
        .add(SearchGeocodingLocationEvent(location: location));
  }

  /// Extract the results from the [HomeBloc]'s state
  /// based on each [HomeState]'s returned values.
  ///
  /// This will return the [ForwardFeature] when
  /// the results from [HomeBloc]'s state was
  /// successful.
  ///
  /// This will return the empty [List] of [Object]
  /// when the returned [HomeState]'s values are
  /// unknown or undefined.
  List<Object> _extractAutoCompleteObjects({
    required HomeState state,
  }) {
    if (state.status == HomeBlocStatus.success) {
      final features = state.forwardGeocodingModel?.features;
      if (features != null) {
        final placeNames =
            features.map<String>((feature) => feature.placeName).toList();
        return placeNames;
      }
    }

    return <Object>[];
  }

  /// Extract the results from the [HomeBloc]'s state
  /// based on each [HomeState]'s returned values.
  ///
  /// This will return the [ForwardFeature] when
  /// the results from [HomeBloc]'s state was
  /// successful and not null.
  ///
  /// This will return empty or null
  /// when the returned [HomeState]'s values are
  /// unknown or undefined.
  ForwardFeature? _extractModelFeature({
    required HomeState state,
    required int index,
  }) {
    if (state.status == HomeBlocStatus.success) {
      final features = state.forwardGeocodingModel?.features;
      if (features != null) {
        final modelFeature = features.elementAt(index);
        return modelFeature;
      }
    }

    return null;
  }

  /// Save the latest [ForwardFeature] from
  /// the [HomeBloc]'s state into the [SharedPreferencesStorage].
  ///
  /// This will return the [Future] of [bool] when the
  /// saving process was completed.
  Future<bool> _saveModelFeatureIntoSharedPreferences({
    required ForwardFeature modelFeature,
  }) {
    return SharedPreferencesStorage.setLatestModelForwardFeature(
      modelFeature: modelFeature,
    );
  }

  /// Load the [ForwardFeature]'s latest saved place name from
  /// [SharedPreferencesStorage] when the saved place name was available.
  ///
  /// This will return the default [String] value when
  /// the latest saved place name was empty.
  String _loadModelFeaturePlaceName() {
    final modelFeature =
        SharedPreferencesStorage.getLatestModelForwardFeature();
    var placeName =
        "Apple Inc., 1 Infinite Loop, Cupertino, California 95014, United States";

    if (modelFeature != null && modelFeature.placeName.isNotEmpty) {
      placeName = modelFeature.placeName;
    }

    return placeName;
  }

  /// Load the [ForwardFeature]'s latest saved latitude from
  /// [SharedPreferencesStorage] when the saved latitude's
  /// coordinate was available.
  ///
  /// This will return the default [double] value when
  /// the latest saved latitude's coordinate was empty.
  double _loadModelFeatureLatitude() {
    final modelFeature =
        SharedPreferencesStorage.getLatestModelForwardFeature();
    var latitude = 37.334795;

    if (modelFeature != null && modelFeature.center.isNotEmpty) {
      latitude = modelFeature.center.last;
    }

    return latitude;
  }

  /// Load the [ForwardFeature]'s latest saved longitude from
  /// [SharedPreferencesStorage] when the saved longitude's
  /// coordinate was available.
  ///
  /// This will return the default [double] value when
  /// the latest saved longitude's coordinate was empty.
  double _loadModelFeatureLongitude() {
    final modelFeature =
        SharedPreferencesStorage.getLatestModelForwardFeature();
    var longitude = -122.009007;

    if (modelFeature != null && modelFeature.center.isNotEmpty) {
      longitude = modelFeature.center.first;
    }

    return longitude;
  }

  /// Save the latest [latitude] coordinate's value into
  /// [SharedPreferencesStorage] when
  /// the [latitude] coordinate's value was available.
  ///
  /// This will return [bool] when the operation inside
  /// [SharedPreferencesStorage] was successful or fail.
  ///
  Future<bool> _saveLatestLatitudeCoordinate({required double latitude}) {
    final operationResults =
        SharedPreferencesStorage.setLatestLatitudeCoordinate(
      latitude: latitude,
    );
    return operationResults;
  }

  /// Save the latest [longitude] coordinate's value into
  /// [SharedPreferencesStorage] when
  /// the [longitude] coordinate's value was available.
  ///
  /// This will return [bool] when the operation inside
  /// [SharedPreferencesStorage] was successful or fail.
  ///
  Future<bool> _saveLatestLongitudeCoordinate({required double longitude}) {
    final operationResults =
        SharedPreferencesStorage.setLatestLongitudeCoordinate(
      longitude: longitude,
    );
    return operationResults;
  }

  /// Send the [FindHourlyWeatherForecastEvent] into the
  /// [HomeBloc] by providing the [context] with
  /// [latitude] and [longitude] coordinates
  /// parameters.
  void _dispatchFindHourlyWeatherForecastEvent({
    required BuildContext context,
    required double latitude,
    required double longitude,
  }) {
    context.read<HomeBloc>().add(
          FindHourlyWeatherForecastEvent(
            latitude: latitude,
            longitude: longitude,
          ),
        );
  }

  /// Extract the results from the [HomeBloc]'s state
  /// based on each [HomeState]'s returned values.
  ///
  /// This will return the [HourlyWeatherForecastModel] when
  /// the results from [HomeBloc]'s state was
  /// successful and not null.
  ///
  /// This will return empty or null
  /// when the returned [HomeState]'s values are
  /// unknown or undefined.
  HourlyWeatherForecastModel? _extractHourlyWeatherForecastModel({
    required HomeState state,
  }) {
    if (state.status == HomeBlocStatus.success) {
      final hourlyWeatherForecast = state.hourlyWeatherForecastModel;

      if (hourlyWeatherForecast != null) {
        return hourlyWeatherForecast;
      }
    }

    return null;
  }

  /// Save the latest [HourlyWeatherForecastModel] from
  /// the [HomeBloc]'s state into the [SharedPreferencesStorage].
  ///
  /// This will return the [Future] of [bool] when the
  /// saving process was completed.
  Future<bool> _saveHourlyWeatherForecastModelIntoSharedPreferences({
    required HourlyWeatherForecastModel hourlyWeatherForecastModel,
  }) {
    return SharedPreferencesStorage.setLatestHourlyWeatherForecastModel(
      hourlyWeatherForecastModel: hourlyWeatherForecastModel,
    );
  }

  /// Load the [HourlyWeatherForecastModel]'s latest saved longitude from
  /// [SharedPreferencesStorage] when the saved longitude's
  /// coordinate was available.
  ///
  /// This will return the default [HourlyWeatherForecastModel] value when
  /// the latest saved [HourlyWeatherForecastModel]'s value was empty.
  HourlyWeatherForecastModel _loadHourlyWeatherForecastModel() {
    final loadedHourlyWeatherForecastModel =
        SharedPreferencesStorage.getLatestHourlyWeatherForecastModel();
    debugPrint(
      "loadHourlyWeatherForecastModel -> $loadedHourlyWeatherForecastModel",
    );

    var hourlyWeatherForecastModel = HourlyWeatherForecastModel.defaultValue();

    if (loadedHourlyWeatherForecastModel != null) {
      hourlyWeatherForecastModel = loadedHourlyWeatherForecastModel;
    }

    return hourlyWeatherForecastModel;
  }

  /// Extract the results from the [HomeBloc]'s state
  /// based on each [HomeState]'s returned values.
  ///
  /// This will return the [HourlyCurrentWeather] when
  /// the results from [HomeBloc]'s state was
  /// successful and not null.
  ///
  /// This will return empty or null
  /// when the returned [HomeState]'s values are
  /// unknown or undefined.
  HourlyCurrentWeather? _extractCurrentWeatherForecast({
    required HomeState state,
  }) {
    if (state.status == HomeBlocStatus.success) {
      final hourlyWeatherForecast = state.hourlyWeatherForecastModel;
      if (hourlyWeatherForecast != null) {
        final currentWeatherForecast =
            hourlyWeatherForecast.hourlyCurrentWeather;
        return currentWeatherForecast;
      }
    }

    return null;
  }

  /// Save the latest [HourlyCurrentWeather] from
  /// the [HomeBloc]'s state into the [SharedPreferencesStorage].
  ///
  /// This will return the [Future] of [bool] when the
  /// saving process was completed.
  Future<bool> _saveHourlyCurrentWeatherIntoSharedPreferences({
    required HourlyCurrentWeather hourlyCurrentWeather,
  }) {
    return SharedPreferencesStorage.setLatestHourlyCurrentWeather(
      hourlyCurrentWeather: hourlyCurrentWeather,
    );
  }

  /// Load the [HourlyCurrentWeather]'s latest saved longitude from
  /// [SharedPreferencesStorage] when the saved longitude's
  /// coordinate was available.
  ///
  /// This will return the default [HourlyCurrentWeather] value when
  /// the latest saved [HourlyCurrentWeather]'s value was empty.
  HourlyCurrentWeather _loadHourlyCurrentWeather() {
    final loadedHourlyCurrentWeather =
        SharedPreferencesStorage.getLatestHourlyCurrentWeather();
    debugPrint("loadHourlyCurrentWeather -> $loadedHourlyCurrentWeather");

    var hourlyCurrentWeather = HourlyCurrentWeather.defaultValue();

    if (loadedHourlyCurrentWeather != null) {
      hourlyCurrentWeather = loadedHourlyCurrentWeather;
    }

    return hourlyCurrentWeather;
  }

  /// Extract the weather temperature in celsius value
  /// based on the [HourlyCurrentWeather]'s object.
  ///
  /// This will return null when the weather temperature
  /// was not available.
  String? _extractWeatherTemperatureInCelsius({
    required HourlyCurrentWeather? hourlyCurrentWeather,
  }) {
    if (hourlyCurrentWeather != null) {
      final currentTemperature = hourlyCurrentWeather.temperature;
      final formattedCurrentTemperature = currentTemperature.toString();
      return formattedCurrentTemperature;
    }

    return null;
  }

  /// Extract the weather code value
  /// based on the [HourlyCurrentWeather]'s object
  /// for convert it into an image inside the assets folder.
  ///
  /// This will return null when the weather code
  /// was not available.
  String? _extractWeatherImage({
    required HourlyCurrentWeather? hourlyCurrentWeather,
    required String? dayDescription,
  }) {
    if (hourlyCurrentWeather != null && dayDescription != null) {
      final currentWeatherCode = hourlyCurrentWeather.weatherCode;
      final convertedWeatherCodeIntoImage =
          WeatherForecastHelper.generateWeatherImage(
        weatherCode: currentWeatherCode,
        dayDescription: dayDescription,
      );
      return convertedWeatherCodeIntoImage;
    }

    return null;
  }

  /// Extract the first weather relative humidity's value
  /// based on the [HourlyWeatherForecastModel]'s object.
  ///
  /// This will return null when the first weather relative humidity
  /// was not available.
  String? _extractWeatherHumidity({
    required HourlyWeatherForecastModel? hourlyWeatherForecastModel,
  }) {
    if (hourlyWeatherForecastModel != null) {
      final currentHourlyNextWeather =
          hourlyWeatherForecastModel.hourlyNextWeather;
      final nextWeatherHumidities = currentHourlyNextWeather.relativeHumidity2M;

      if (nextWeatherHumidities.isNotEmpty) {
        final firstWeatherHumidity = nextWeatherHumidities.first;
        final formattedFirstWeatherHumidity = firstWeatherHumidity.toString();
        return formattedFirstWeatherHumidity;
      }
    }

    return null;
  }

  /// Extract the weather precipitation percentage's value
  /// based on the [HourlyWeatherForecastModel]'s object.
  ///
  /// This will return null when the precipitation percentage
  /// was not available.
  String? _extractWeatherPrecipitationPercentage({
    required HourlyWeatherForecastModel? hourlyWeatherForecastModel,
  }) {
    if (hourlyWeatherForecastModel != null) {
      final currentHourlyNextWeather =
          hourlyWeatherForecastModel.hourlyNextWeather;
      final nextWeatherPrecipitations =
          currentHourlyNextWeather.precipitationProbability;

      if (nextWeatherPrecipitations.isNotEmpty) {
        final firstWeatherPrecipitation = nextWeatherPrecipitations.first;
        final formattedFirstWeatherPrecipitation =
            firstWeatherPrecipitation.toString();
        return formattedFirstWeatherPrecipitation;
      }
    }

    return null;
  }

  /// Extract the weather pressure's value
  /// based on the [HourlyWeatherForecastModel]'s object.
  ///
  /// This will return null when the weather pressure
  /// was not available.
  String? _extractWeatherPressure({
    required HourlyWeatherForecastModel? hourlyWeatherForecastModel,
  }) {
    if (hourlyWeatherForecastModel != null) {
      final currentHourlyNextWeather =
          hourlyWeatherForecastModel.hourlyNextWeather;
      final nextWeatherPressures = currentHourlyNextWeather.surfacePressure;

      if (nextWeatherPressures.isNotEmpty) {
        final firstWeatherPressure = nextWeatherPressures.first;
        final formattedFirstWeatherPressure = firstWeatherPressure.toString();
        return formattedFirstWeatherPressure;
      }
    }

    return null;
  }

  /// Extract the weather wind speed's value
  /// based on the [HourlyCurrentWeather]'s object.
  ///
  /// This will return null when the weather wind speed
  /// was not available.
  String? _extractWeatherWindSpeed({
    required HourlyCurrentWeather? hourlyCurrentWeather,
  }) {
    if (hourlyCurrentWeather != null) {
      final currentWindSpeed = hourlyCurrentWeather.windSpeed;
      final formattedCurrentWindSpeed = currentWindSpeed.toString();
      return formattedCurrentWindSpeed;
    }

    return null;
  }
}
