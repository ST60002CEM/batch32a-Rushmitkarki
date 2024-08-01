import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';
import 'package:final_assignment/features/myappointment/data/data_source/remote/appointment_list_remote_data_source.dart';


class AppointmentListRepositoryImpl implements AppointmentRepository {
  final AppointmentListRemoteDataSource remoteDataSource;

  AppointmentListRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Appointment>> fetchAppointments() async {
    final appointmentModels = await remoteDataSource.fetchUserAppointments();
    return appointmentModels.map((model) => Appointment(
      id: model.id,
      patientName: model.patientName,
      email: model.email,
      appointmentDate: model.appointmentDate,
      phoneNumber: model.phoneNumber,
      appointmentDescription: model.appointmentDescription,
    )).toList();
  }

  @override
  Future<void> createAppointment(Appointment appointment) {
    // Implement if needed
    throw UnimplementedError();
  }
}
