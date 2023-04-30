import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_feature.dart';

class ForwardGeocodingModel extends Equatable {
  final String type;
  final List<String> queries;
  final List<ForwardFeature> features;
  final String attribution;

  const ForwardGeocodingModel({
    required this.type,
    required this.queries,
    required this.features,
    required this.attribution,
  });

  factory ForwardGeocodingModel.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an error of subtype.

    var defaultType = "";
    var defaultQueries = <String>[];
    var defaultFeatures = <ForwardFeature>[];
    var defaultAttribution = "";

    if (json['type'] != null &&
        json['query'] != null &&
        json['features'] != null &&
        json['attribution'] != null) {
      final jsonType = json['type'] as String;
      defaultType = jsonType;

      final jsonQueries = json['query'] as List<dynamic>;
      final queries = jsonQueries.map<String>((e) => e as String).toList();
      defaultQueries = queries;

      final jsonFeatures = json['features'] as List<dynamic>;
      final features = jsonFeatures
          .map<ForwardFeature>(
              (e) => ForwardFeature.fromJson(e as Map<String, dynamic>))
          .toList();
      defaultFeatures = features;

      final jsonAttribution = json['attribution'] as String;
      defaultAttribution = jsonAttribution;
    }

    return ForwardGeocodingModel(
      type: defaultType,
      queries: defaultQueries,
      features: defaultFeatures,
      attribution: defaultAttribution,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'query': queries,
        'features': features,
        'attribution': attribution,
      };

  @override
  List<Object?> get props => [type, queries, features, attribution];

  @override
  bool? get stringify => true;
}
