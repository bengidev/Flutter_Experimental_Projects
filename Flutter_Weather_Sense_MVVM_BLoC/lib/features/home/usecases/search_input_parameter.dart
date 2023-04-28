import 'package:equatable/equatable.dart';

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
