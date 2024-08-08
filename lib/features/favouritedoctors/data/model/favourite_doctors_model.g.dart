// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_doctors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteDoctor _$FavouriteDoctorFromJson(Map<String, dynamic> json) =>
    FavouriteDoctor(
      id: json['_id'] as String,
      doctor: DoctorApiModel.fromJson(json['doctor'] as Map<String, dynamic>),
      user: AuthApiModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavouriteDoctorToJson(FavouriteDoctor instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'doctor': instance.doctor,
      'user': instance.user,
    };
