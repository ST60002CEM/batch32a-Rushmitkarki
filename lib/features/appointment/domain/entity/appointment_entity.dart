
import 'package:equatable/equatable.dart';

import '../../../auth/domain/entity/auth_entity.dart';

class AppointmentEntity extends Equatable {
  final String? id;
  final String patientName;
  final String email;
  final DateTime appointmentDate;
  final String phoneNumber;
  final String appointmentDescription;
  final String? status;
  final AuthEntity? authEntity;

  AppointmentEntity({
     this.id,
    required this.patientName,
    required this.email,
    required this.appointmentDate,
    required this.phoneNumber,
    required this.appointmentDescription,
     this.status,
    this.authEntity,
  });

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
