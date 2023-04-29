import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/context.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/geometry.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/properties.dart';

/// The [Feature] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class Feature extends Equatable {
  final String id;
  final String type;
  final List<String> placeType;
  final int relevance;
  final Properties properties;
  final String text;
  final String placeName;
  final List<double> bbox;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  const Feature({
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

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json['id'] as String,
        type: json['type'] as String,
        placeType: json['place_type'] as List<String>,
        relevance: json['relevance'] as int,
        properties: Properties.fromJson(
          json['properties'] as Map<String, dynamic>,
        ),
        text: json['text'] as String,
        placeName: json['place_name'] as String,
        bbox: json['bbox'] as List<double>,
        center: json['center'] as List<double>,
        geometry: Geometry.fromJson(
          json['geometry'] as Map<String, dynamic>,
        ),
        context: json['context'] as List<Context>,
      );

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

  @override
  bool? get stringify => true;
}
