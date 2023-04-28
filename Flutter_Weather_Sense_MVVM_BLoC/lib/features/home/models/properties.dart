import 'package:equatable/equatable.dart';

class Properties extends Equatable {
  final String wikidata;
  final String mapboxId;

  const Properties({
    required this.wikidata,
    required this.mapboxId,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json['wikidata'] as String,
        mapboxId: json['mapbox_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'wikidata': wikidata,
        'mapbox_id': mapboxId,
      };

  @override
  List<Object?> get props => [wikidata, mapboxId];

  @override
  bool? get stringify => true;
}
