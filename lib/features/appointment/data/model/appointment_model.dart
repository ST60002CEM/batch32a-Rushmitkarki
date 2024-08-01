

import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    required String id,
    required String patientName,
    required String email,
    required DateTime appointmentDate,
    required String phoneNumber,
    required String appointmentDescription,
  }) : super(
          id: id,
          patientName: patientName,
          email: email,
          appointmentDate: appointmentDate,
          phoneNumber: phoneNumber,
          appointmentDescription: appointmentDescription,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      patientName: json['patientName'],
      email: json['email'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      phoneNumber: json['phoneNumber'],
      appointmentDescription: json['appointmentDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'email': email,
      'appointmentDate': appointmentDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'appointmentDescription': appointmentDescription,
    };
  }
}
