import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/view_models/home_bloc.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/views/home_views_barrel.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greetingDescription = useState<String>("Hallo, ");
    final firstFocusNode = useFocusNode();
    final firstTextEditingController = useTextEditingController();

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
      [greetingDescription, firstTextEditingController],
    );

    return BlocProvider(
      create: (context) => $serviceLocator.get<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
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
                      objects: _extractAutoCompleteObjects(state: state),
                      onPressed: (resultText) async {
                        debugPrint("onPressed Result Text -> $resultText");
                        _dispatchSearchLocationEvent(
                          context: context,
                          location: resultText ?? '',
                        );
                      },
                      onResult: (resultText) async {
                        _dispatchSearchLocationEvent(
                          context: context,
                          location: resultText ?? '',
                        );
                        debugPrint("onChanged Result Text -> $resultText");
                      },
                    ),
                    Gap($styles.insets.sm),

                    // Body Section
                    const HomeLocationMap(),
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
                ),
              ),
            ),
          );
        },
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
  /// It will return the empty [List] of [Object]
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
      } else {
        return <Object>[];
      }
    } else {
      return <Object>[];
    }
  }
}
