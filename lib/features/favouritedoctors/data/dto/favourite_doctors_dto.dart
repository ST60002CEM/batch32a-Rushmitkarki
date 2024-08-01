import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';



class FavouriteDoctorDto {
  final String id;
  final String name;
  final String field;

  FavouriteDoctorDto({
    required this.id,
    required this.name,
    required this.field,
  });

  factory FavouriteDoctorDto.fromJson(Map<String, dynamic> json) {
    return FavouriteDoctorDto(
      id: json['id'],
      name: json['name'],
      field: json['field'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'field': field,
    };
  }

  FavouriteDoctor toEntity() {
    return FavouriteDoctor(
      id: id,
      name: name,
      field: field,
    );
  }
}
