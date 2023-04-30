import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';

/// The [ForwardProperty] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class ForwardProperty extends Equatable {
  final String wikidata;
  final String mapboxId;

  const ForwardProperty({
    required this.wikidata,
    required this.mapboxId,
  });

  /// Deserialize the given [json] object into a [ForwardProperty]
  /// by using the [JsonDecoder] functionality.
  factory ForwardProperty.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an error of subtype.

    var defaultWikiData = "";
    var defaultMapboxId = "";

    if (json['wikidata'] != null && json['mapbox_id'] != null) {
      final jsonWikiData = json['wikidata'] as String;
      defaultWikiData = jsonWikiData;

      final jsonMapboxId = json['mapbox_id'] as String;
      defaultMapboxId = jsonMapboxId;
    }

    return ForwardProperty(
      wikidata: defaultWikiData,
      mapboxId: defaultMapboxId,
    );
  }

  /// Convert this [ForwardProperty] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'wikidata': wikidata,
        'mapbox_id': mapboxId,
      };

  /// Returns a new object of [ForwardProperty]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ForwardProperty copyWith({
    String? wikidata,
    String? mapboxId,
  }) {
    return ForwardProperty(
      wikidata: wikidata ?? this.wikidata,
      mapboxId: mapboxId ?? this.mapboxId,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [wikidata, mapboxId];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
