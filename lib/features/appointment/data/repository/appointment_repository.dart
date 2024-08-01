
import 'package:final_assignment/features/appointment/data/data_source/remote/appointment_remote_data_source.dart';
import 'package:final_assignment/features/appointment/data/model/appointment_model.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';


class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createAppointment(Appointment appointment) async {
    final appointmentModel = AppointmentModel(
      id: appointment.id,
      patientName: appointment.patientName,
      email: appointment.email,
      appointmentDate: appointment.appointmentDate,
      phoneNumber: appointment.phoneNumber,
      appointmentDescription: appointment.appointmentDescription,
    );
    await remoteDataSource.createAppointment(appointmentModel);
  }

  @override
  Future<List<Appointment>> fetchAppointments() async {
    final appointments = await remoteDataSource.fetchAppointments();
    return appointments.map((model) => Appointment(
      id: model.id,
      patientName: model.patientName,
      email: model.email,
      appointmentDate: model.appointmentDate,
      phoneNumber: model.phoneNumber,
      appointmentDescription: model.appointmentDescription,
    )).toList();
  }
}
