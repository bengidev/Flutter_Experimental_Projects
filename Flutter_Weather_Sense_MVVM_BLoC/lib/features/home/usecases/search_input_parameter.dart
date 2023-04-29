import 'package:equatable/equatable.dart';

/// The parameter object of the use case's implementation.
/// This will give you the easy access of all the
/// required object with just a single use case's parameter.
class SearchInputParameter extends Equatable {
  final String location;

  const SearchInputParameter({
    required this.location,
  });

  @override
  List<Object?> get props => [location];

  @override
  bool get stringify => true;
}
