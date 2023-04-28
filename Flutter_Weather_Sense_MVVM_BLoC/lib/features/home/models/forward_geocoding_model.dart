import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/feature.dart';

class ForwardGeocodingModel extends Equatable {
  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  const ForwardGeocodingModel({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  factory ForwardGeocodingModel.fromJson(Map<String, dynamic> json) =>
      ForwardGeocodingModel(
        type: json['type'] as String,
        query: json['query'] as List<String>,
        features: json['features'] as List<Feature>,
        attribution: json['attribution'] as String,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'query': query,
        'features': features,
        'attribution': attribution,
      };

  @override
  List<Object?> get props => [type, query, features, attribution];

  @override
  bool? get stringify => true;
}
