import 'dart:convert';

import 'package:equatable/equatable.dart';

/// The [ForwardContext] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class ForwardContext extends Equatable {
  final String id;
  final String shortCode;
  final String wikidata;
  final String mapboxId;
  final String text;

  const ForwardContext({
    required this.id,
    required this.shortCode,
    required this.wikidata,
    required this.mapboxId,
    required this.text,
  });

  /// Deserialize the given [json] object into a [ForwardContext]
  /// by using the [JsonDecoder] functionality.
  factory ForwardContext.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an error of subtype.

    var defaultId = "";
    var defaultShortCode = "";
    var defaultWikiData = "";
    var defaultMapboxId = "";
    var defaultText = "";

    if (json['id'] != null &&
        json['wikidata'] != null &&
        json['mapbox_id'] != null &&
        json['text'] != null) {
      final jsonId = json['id'] as String;
      defaultId = jsonId;

      final jsonShortCode = json['short_code'] as String?;
      if (jsonShortCode != null) defaultShortCode = jsonShortCode;

      final jsonWikiData = json['wikidata'] as String;
      defaultWikiData = jsonWikiData;

      final jsonMapboxId = json['mapbox_id'] as String;
      defaultMapboxId = jsonMapboxId;

      final jsonText = json['text'] as String;
      defaultText = jsonText;
    }

    return ForwardContext(
      id: defaultId,
      shortCode: defaultShortCode,
      wikidata: defaultWikiData,
      mapboxId: defaultMapboxId,
      text: defaultText,
    );
  }

  /// Convert this [ForwardContext] into a [json] object
  /// by using the [JsonEncoder] functionality.
  Map<String, dynamic> toJson() => {
        'id': id,
        'short_code': shortCode,
        'wikidata': wikidata,
        'mapbox_id': mapboxId,
        'text': text,
      };

  /// Returns a new object of [ForwardContext]
  /// with the same properties as the original,
  /// but with some of the values changed.
  ForwardContext copyWith({
    String? id,
    String? shortCode,
    String? wikidata,
    String? mapboxId,
    String? text,
  }) {
    return ForwardContext(
      id: id ?? this.id,
      shortCode: shortCode ?? this.shortCode,
      wikidata: wikidata ?? this.wikidata,
      mapboxId: mapboxId ?? this.mapboxId,
      text: text ?? this.text,
    );
  }

  /// The list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [id, shortCode, wikidata, mapboxId, text];

  /// Implement [toString] method including all the given props
  /// by changing the [stringify] value into [true]
  @override
  bool? get stringify => true;
}
