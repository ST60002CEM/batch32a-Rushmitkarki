import 'package:equatable/equatable.dart';

class FavouriteDoctor extends Equatable {
  final String id;
  final String name;
  final String field;

  const FavouriteDoctor({
    required this.id,
    required this.name,
    required this.field,
  });

  @override
  List<Object?> get props => [id, name, field];
}
