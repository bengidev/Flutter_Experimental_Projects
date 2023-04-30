import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';

/// The [ForwardProperties] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class ForwardProperties extends Equatable {
  final String wikidata;
  final String mapboxId;

  const ForwardProperties({
    required this.wikidata,
    required this.mapboxId,
  });

  factory ForwardProperties.fromJson(Map<String, dynamic> json) {
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

    return ForwardProperties(
      wikidata: defaultWikiData,
      mapboxId: defaultMapboxId,
    );
  }

  Map<String, dynamic> toJson() => {
        'wikidata': wikidata,
        'mapbox_id': mapboxId,
      };

  @override
  List<Object?> get props => [wikidata, mapboxId];

  @override
  bool? get stringify => true;
}
