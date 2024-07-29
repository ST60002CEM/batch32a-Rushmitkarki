import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';


class GetAppointmentUseCase {
  final AppointmentRepository repository;

  GetAppointmentUseCase(this.repository);

  Future<Either<Failure, Appointment>> call(String appointmentId) {
    return repository.getAppointment(appointmentId);
  }
}
