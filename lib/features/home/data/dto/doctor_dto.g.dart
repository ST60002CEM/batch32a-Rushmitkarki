// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorDto _$DoctorDtoFromJson(Map<String, dynamic> json) => DoctorDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      doctors: (json['doctors'] as List<dynamic>)
          .map((e) => DoctorApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorDtoToJson(DoctorDto instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'doctors': instance.doctors,
    };
