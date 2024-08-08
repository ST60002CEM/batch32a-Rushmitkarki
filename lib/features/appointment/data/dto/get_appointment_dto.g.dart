// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_appointment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppointmentDto _$GetAppointmentDtoFromJson(Map<String, dynamic> json) =>
    GetAppointmentDto(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAppointmentDtoToJson(GetAppointmentDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
