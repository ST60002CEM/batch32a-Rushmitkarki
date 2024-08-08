import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentUsecaseProvider = Provider<AppointmentUsecase>((ref) {
  return AppointmentUsecase(ref.watch(appointmentRepositoryProvider));
});

class AppointmentUsecase {
  final AppointmentRepository repository;

  AppointmentUsecase(this.repository);

  Future<Either<Failure, bool>> addAppointment(AppointmentEntity appointment) {
    return repository.createAppointment(appointment);
  }

  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() {
    return repository.getAppointments();
  }
}
