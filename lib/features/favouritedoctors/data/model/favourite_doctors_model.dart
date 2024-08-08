import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/home/data/model/doctor_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/favourite_entity.dart';

part 'favourite_doctors_model.g.dart';

final favouriteDoctorApiModelProvider = Provider<FavouriteDoctor>((ref) {
  return const FavouriteDoctor.empty();
});

@JsonSerializable()
class FavouriteDoctor extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final DoctorApiModel doctor;
  final AuthApiModel user;

  const FavouriteDoctor({

    required this.id,
    required this.doctor,
    required this.user,
  });

  // empty
   const FavouriteDoctor.empty()
      : id = '',
        doctor = const DoctorApiModel.empty(),
        user =  const AuthApiModel.empty();


  factory FavouriteDoctor.fromJson(Map<String, dynamic> json) =>
      _$FavouriteDoctorFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteDoctorToJson(this);

  // to entity
  FavouriteEntity toEntity() {
    return FavouriteEntity(
      id: id,
      doctor: doctor.toEntity(),
      user: user.toEntity(),
    );
  }

  // from entity
  factory FavouriteDoctor.fromEntity(FavouriteEntity entity) {
    return FavouriteDoctor(
      id: entity.id,
      doctor: DoctorApiModel.fromEntity(entity.doctor),
      user: AuthApiModel.fromEntity(entity.user),
    );
  }

  // to entity list
  static List<FavouriteDoctor> toEntityList(List<FavouriteEntity> favourites) {
    return favourites.map((favourite) => FavouriteDoctor.fromEntity(favourite)).toList();
  }

  // from entity list
  static List<FavouriteEntity> fromEntityList(List<FavouriteDoctor> favourites) {
    return favourites.map((favourite) => favourite.toEntity()).toList();
  }






  @override
  List<Object?> get props => [id, doctor, user];
}
