// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) =>
    AppointmentModel(
      id: json['_id'] as String?,
      patientName: json['patientName'] as String,
      email: json['email'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
      appointmentDescription: json['appointmentDescription'] as String,
      status: json['status'] as String?,
      authEntity: json['authEntity'] == null
          ? null
          : AuthApiModel.fromJson(json['authEntity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppointmentModelToJson(AppointmentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'patientName': instance.patientName,
      'email': instance.email,
      'appointmentDate': instance.appointmentDate.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'appointmentDescription': instance.appointmentDescription,
      'status': instance.status,
      'authEntity': instance.authEntity,
    };
