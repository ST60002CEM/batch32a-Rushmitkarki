

import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';

class CreateAppointment {
  final AppointmentRepository repository;

  CreateAppointment(this.repository);

  Future<void> call(Appointment appointment) async {
    await repository.createAppointment(appointment);
  }

  addAppointment(Appointment appointment) {}
}
