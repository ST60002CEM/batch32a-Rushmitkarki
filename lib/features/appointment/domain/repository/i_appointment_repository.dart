


import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment(Appointment appointment);
  Future<List<Appointment>> fetchAppointments();
}
