import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';



class FavouriteDoctorDto {
  final bool success;
  final List<FavouriteDoctor> favorites;

  FavouriteDoctorDto({required this.success, required this.favorites});

//   from json
  factory FavouriteDoctorDto.fromJson(Map<String, dynamic> json) {
    return FavouriteDoctorDto(
      success: json['success'],
      favorites: (json['favorites'] as List)
          .map((doctor) => FavouriteDoctor.fromJson(doctor))
          .toList(),
    );
  }

//   to json
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'favorites': favorites.map((doctor) => doctor.toJson()).toList(),
    };
  }


}