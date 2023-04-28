import 'package:equatable/equatable.dart';

class Geometry extends Equatable {
  final String type;
  final List<double> coordinates;

  const Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      type: json['type'] as String,
      coordinates: json['coordinates'] as List<double>,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  @override
  List<Object?> get props => [type, coordinates];

  @override
  bool? get stringify => true;
}
