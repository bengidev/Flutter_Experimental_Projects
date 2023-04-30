import 'package:equatable/equatable.dart';
import 'package:flutter_weather_sense_mvvm_bloc/features/home/models/forward_geocoding_model.dart';

/// The [ForwardGeometry] object will be a part of the [ForwardGeocodingModel].
/// This object is not appropriate to be created/used for the
/// stand-alone object.
class ForwardGeometry extends Equatable {
  final String type;
  final List<double> coordinates;

  const ForwardGeometry({
    required this.type,
    required this.coordinates,
  });

  factory ForwardGeometry.fromJson(Map<String, dynamic> json) {
    // The json list value's subtype is [dynamic],
    // so it cannot be explicitly typecast-ed to the subtype that you want.
    // You must safely typecast the value before you used it,
    // or it will show an error of subtype.

    var defaultCoordinates = <double>[];

    if (json['coordinates'] != null) {
      final jsonCoordinates = json['coordinates'] as List<dynamic>;
      final coordinates =
          jsonCoordinates.map<double>((e) => e as double).toList();
      defaultCoordinates = coordinates;
    }

    return ForwardGeometry(
      type: json['type'] as String,
      coordinates: defaultCoordinates,
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
