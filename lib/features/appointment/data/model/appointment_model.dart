import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment_model.g.dart';

final appointmentModelProvider = Provider<AppointmentModel>((ref) {
  return AppointmentModel.empty();
});

@JsonSerializable()
class AppointmentModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String patientName;
  final String email;
  final DateTime appointmentDate;
  final String phoneNumber;
  final String appointmentDescription;
  final String? status;
  final AuthApiModel? authEntity;

  AppointmentModel({
    this.id,
    required this.patientName,
    required this.email,
    required this.appointmentDate,
    required this.phoneNumber,
    required this.appointmentDescription,
    this.status,
    this.authEntity,
  });

  AppointmentModel.empty() :
    id = '',
    patientName = '',
    email = '',
    appointmentDate = DateTime.now(),
    phoneNumber = '',
    appointmentDescription = '',
    status = '',
    authEntity = AuthApiModel.empty();

  // from json
  factory AppointmentModel.fromJson(Map<String, dynamic> json) => _$AppointmentModelFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AppointmentModelToJson(this);

  // from entity
  factory AppointmentModel.fromEntity(AppointmentEntity entity) => AppointmentModel(
    id: entity.id,
    patientName: entity.patientName,
    email: entity.email,
    appointmentDate: entity.appointmentDate,
    phoneNumber: entity.phoneNumber,
    appointmentDescription: entity.appointmentDescription,
    status: entity.status,
    authEntity: entity.authEntity != null ? AuthApiModel.fromEntity(entity.authEntity!) : null,
  );

  // to entity
  AppointmentEntity toEntity() => AppointmentEntity(
    id: id,
    patientName: patientName,
    email: email,
    appointmentDate: appointmentDate,
    phoneNumber: phoneNumber,
    appointmentDescription: appointmentDescription,
    status: status,
    authEntity: authEntity != null ? authEntity!.toEntity() : null,
  );

  // to entity list
  static List<AppointmentEntity> toEntities(List<AppointmentModel> models) => models.map((model) => model.toEntity()).toList();




  @override
  List<Object?> get props => [
    id,
    patientName,
    email,
    appointmentDate,
    phoneNumber,
    appointmentDescription,
    status,
    authEntity,
  ];
}
