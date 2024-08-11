import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/data/data_source/remote/appointment_remote_data_source.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentRemoteRepositoryProvider =
    Provider<AppointmentRepository>((ref) {
  return AppointmentRemoteRepository(
      remoteDataSource: ref.watch(appointmentRemoteDataSourceProvider));
});

class AppointmentRemoteRepository implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment) {
    return remoteDataSource.createAppointment(appointment);
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() {
    return remoteDataSource.fetchAppointments();
  }

  @override
  Future<Either<Failure, bool>> cancelAppointment(String id) {
    return remoteDataSource.cancelAppointment(id);
  }
}
