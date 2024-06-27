// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorApiModel _$DoctorApiModelFromJson(Map<String, dynamic> json) =>
    DoctorApiModel(
      id: json['_id'] as String?,
      doctorName: json['doctorName'] as String,
      doctorField: json['doctorField'] as String,
      doctorExperience: json['doctorExperience'] as String,
      doctorFee: json['doctorFee'] as String,
      doctorImage: json['doctorImage'] as String,
    );

Map<String, dynamic> _$DoctorApiModelToJson(DoctorApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'doctorName': instance.doctorName,
      'doctorField': instance.doctorField,
      'doctorExperience': instance.doctorExperience,
      'doctorFee': instance.doctorFee,
      'doctorImage': instance.doctorImage,
    };
