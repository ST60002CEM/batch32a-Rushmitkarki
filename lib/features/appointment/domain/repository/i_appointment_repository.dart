import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';


abstract class AppointmentRepository {
  Future<Either<Failure, Appointment>> getAppointment(String appointmentId);
}
