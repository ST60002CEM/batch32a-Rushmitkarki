import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/data/data_source/remote/appointment_remote_data_source.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';

import 'package:dartz/dartz.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Appointment>> getAppointment(String appointmentId) async {
    try {
      final appointmentModel = await remoteDataSource.getAppointment(appointmentId);
      return Right(appointmentModel);
    } catch (error) {
      return Left(ServerFailure());
    }
  }
}
