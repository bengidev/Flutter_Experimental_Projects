import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_feature.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_views_barrel.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greetingDescription = useState<String>("Hallo, ");
    final firstFocusNode = useFocusNode();
    final firstTextEditingController = useTextEditingController();
    final cacheModelObjects = useState<List<Object>>(<Object>[]);

    /// Useful for side-effects and optionally canceling them.
    /// useEffect is called synchronously on every build, unless keys is specified.
    /// In which case useEffect is called again only,
    /// if any value inside keys as changed.
    useEffect(
      () {
        // Start the following events when the widget is first rendered.
        Future.microtask(() {
          greetingDescription.value = _generateGreetingDay(
            time: DateTime.now(),
          );

          debugPrint("Microtask from UseEffect: $greetingDescription");
        });

        // We could optionally return some "dispose" logic here.
        // We can return more than one disposing event by
        // returning a void Function, like return () {}.
        return null;
      },
      // Tell Flutter to rebuild this widget when
      // the values inside the bracket updates.
      [
        greetingDescription,
        firstFocusNode,
        firstTextEditingController,
        cacheModelObjects,
      ],
    );

    return BlocProvider(
      create: (context) => $serviceLocator.get<HomeBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // Header Section
                    HomeGreetingDescription(
                      greetingMessage: greetingDescription.value,
                    ),
                    Gap($styles.insets.md),

                    // Header Section
                    AppRawAutoCompleteField(
                      key: const ValueKey('FIRST_APP_TEXT_FORM_FIELD'),
                      focusNode: firstFocusNode,
                      textEditingController: firstTextEditingController,
                      objects: _extractAutoCompleteObjects(
                        state: state,
                        previousObjects: cacheModelObjects.value,
                      ),
                      onPressed: (resultText, index) async {
                        // Send the [resultText] into the [HomeBloc]'s event.
                        _dispatchSearchLocationEvent(
                          context: context,
                          location: resultText,
                        );

                        // Change the [cacheModelObjects] value with
                        // the value of [_extractAutoCompleteObjects]' method.
                        cacheModelObjects.value = _extractAutoCompleteObjects(
                          state: state,
                          previousObjects: ["Not Available"],
                        );

                        // Save the [extractedModelFeature]'s value when
                        // the value was not empty.
                        final extractedModelFeature = _extractModelFeature(
                          state: state,
                          index: index,
                        );
                        if (extractedModelFeature != null) {
                          await _saveModelFeatureIntoSharedPreferences(
                            modelFeature: extractedModelFeature,
                          );
                        }
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
                      latitude: _loadModelFeatureLatitude(),
                      longitude: _loadModelFeatureLongitude(),
                    ),
                    Gap($styles.insets.sm),

                    // Body Section
                    const HomeWeatherCard(),
                    Gap($styles.insets.lg),

                    // Body Section
                    const HomeEarlyWarningDescription(),
                    Gap($styles.insets.sm),

                    // Footer Section
                    const HomeEarlyWarningCards(),
                  ],
                );
              },
            ),
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
    var stringResults = "";
    final greetingResults = GreetingOfDay.getFromTime(
      time: time,
    );
    greetingResults.fold(
      (failure) => stringResults = failure.toString(),
      (results) => stringResults = results,
    );
    return stringResults;
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
    required List<Object> previousObjects,
  }) {
    if (state.status == HomeBlocStatus.success) {
      final features = state.forwardGeocodingModel?.features;
      if (features != null) {
        final placeNames =
            features.map<String>((feature) => feature.placeName).toList();
        previousObjects = placeNames;
        return placeNames;
      }
    }

    return previousObjects;
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

  /// Load the latest saved place name from [ForwardFeature]
  /// when the saved place name was available.
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

  /// Load the latest saved latitude from [ForwardFeature]
  /// when the saved latitude's coordinate was available.
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

  /// Load the latest saved longitude from [ForwardFeature]
  /// when the saved longitude's coordinate was available.
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
}
