import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';


class AppointmentModel extends Appointment {
  AppointmentModel({
    required String patientName,
    required String email,
    required DateTime appointmentDate,
    required String phone,
    required String description,
  }) : super(
          patientName: patientName,
          email: email,
          appointmentDate: appointmentDate,
          phoneNumber: phone,
          appointmentDescription: appointmentDescription,
        );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientName: json['patientName'],
      email: json['email'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      phone: json['phone'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientName': patientName,
      'email': email,
      'appointmentDate': appointmentDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'appointmentDescription': appointmentDescription,
    };
  }
}
