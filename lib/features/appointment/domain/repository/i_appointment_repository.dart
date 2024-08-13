import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/appointment_remote_repository.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return ref.watch(appointmentRemoteRepositoryProvider);
});

abstract class AppointmentRepository {
  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment);

  Future<Either<Failure, List<AppointmentEntity>>> getAppointments();

//   cancel appointment
  Future<Either<Failure, bool>> cancelAppointment(String id);
}
