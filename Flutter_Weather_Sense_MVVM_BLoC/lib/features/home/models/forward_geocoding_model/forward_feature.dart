import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model/forward_context.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model/forward_geometry.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model/forward_property.dart';

/// The [ForwardFeature] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class ForwardFeature extends Equatable {
  final String id;
  final String type;
  final List<String> placeType;
  final int relevance;
  final ForwardProperty properties;
  final String text;
  final String placeName;
  final List<double> bbox;
  final List<double> center;
  final ForwardGeometry geometry;
  final List<ForwardContext> context;

  const ForwardFeature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.bbox,
    required this.center,
    required this.geometry,
    required this.context,
  });

  /// Deserialize the given [json] object into a [ForwardFeature]
  /// by using the [JsonDecoder] functionality.
  factory ForwardFeature.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an error of subtype.

    var defaultId = "";
    var defaultType = "";
    var defaultPlaceType = <String>[];
    var defaultRelevance = 0;
    var defaultProperties = const ForwardProperty(wikidata: '', mapboxId: '');
    var defaultText = "";
    var defaultPlaceName = "";
    var defaultBbox = <double>[];
    var defaultCenter = <double>[];
    var defaultGeometry =
        const ForwardGeometry(type: '', coordinates: <double>[]);
    var defaultContext = <ForwardContext>[];

    if (json['id'] != null &&
        json['type'] != null &&
        json['place_type'] != null &&
        json['relevance'] != null &&
        json['properties'] != null &&
        json['text'] != null &&
        json['place_name'] != null &&
        json['bbox'] != null &&
        json['center'] != null &&
        json['geometry'] != null &&
        json['context'] != null) {
      final jsonId = json['id'] as String;
      defaultId = jsonId;

      final jsonType = json['type'] as String;
      defaultType = jsonType;

      final jsonPlaceType = json['place_type'] as List<dynamic>;
      final placeType = jsonPlaceType.map<String>((e) => e as String).toList();
      defaultPlaceType = placeType;

      final jsonRelevance = json['relevance'] as int;
      defaultRelevance = jsonRelevance;

      final jsonProperties = json['properties'] as Map<String, dynamic>;
      final properties = ForwardProperty.fromJson(jsonProperties);
      defaultProperties = properties;

      final jsonText = json['text'] as String;
      defaultText = jsonText;

      final jsonPlaceName = json['place_name'] as String;
      defaultPlaceName = jsonPlaceName;

      final jsonBbox = json['bbox'] as List<dynamic>;
      final bbox = jsonBbox.map<double>((e) => e as double).toList();
      defaultBbox = bbox;

      final jsonCenter = json['center'] as List<dynamic>;
      final center = jsonCenter.map<double>((e) => e as double).toList();
      defaultCenter = center;

      final jsonGeometry = json['geometry'] as Map<String, dynamic>;
      final geometry = ForwardGeometry.fromJson(jsonGeometry);
      defaultGeometry = geometry;

      final jsonContext = json['context'] as List<dynamic>;
      final context = jsonContext
          .map<ForwardContext>(
              (e) => ForwardContext.fromJson(e as Map<String, dynamic>))
          .toList();
      defaultContext = context;
    }

    return ForwardFeature(
      id: defaultId,
      type: defaultType,
      placeType: defaultPlaceType,
      relevance: defaultRelevance,
      properties: defaultProperties,
      text: defaultText,
      placeName: defaultPlaceName,
      bbox: defaultBbox,
      center: defaultCenter,
      geometry: defaultGeometry,
      context: defaultContext,
    );
  }

  /// Convert this [ForwardFeature] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'place_type': placeType,
        'relevance': relevance,
        'properties': properties.toJson(),
        'text': text,
        'place_name': placeName,
        'bbox': bbox,
        'center': center,
        'geometry': geometry.toJson(),
        'context': context,
      };

  /// Returns a new object of [ForwardFeature]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ForwardFeature copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    int? relevance,
    ForwardProperty? properties,
    String? text,
    String? placeName,
    List<double>? bbox,
    List<double>? center,
    ForwardGeometry? geometry,
    List<ForwardContext>? context,
  }) {
    return ForwardFeature(
      id: id ?? this.id,
      type: type ?? this.type,
      placeType: placeType ?? this.placeType,
      relevance: relevance ?? this.relevance,
      properties: properties ?? this.properties,
      text: text ?? this.text,
      placeName: placeName ?? this.placeName,
      bbox: bbox ?? this.bbox,
      center: center ?? this.center,
      geometry: geometry ?? this.geometry,
      context: context ?? this.context,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [
        id,
        type,
        placeType,
        relevance,
        properties,
        text,
        placeName,
        bbox,
        center,
        geometry,
        context,
      ];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
