

import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';

class FetchAppointments {
  final AppointmentRepository repository;

  FetchAppointments(this.repository);

  Future<List<Appointment>> call() async {
    return await repository.fetchAppointments();
  }
}
