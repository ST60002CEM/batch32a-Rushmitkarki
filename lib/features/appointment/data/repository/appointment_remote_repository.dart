import 'package:final_assignment/features/appointment/data/data_source/remote/appointment_remote_data_source.dart';
import 'package:final_assignment/features/appointment/domain/repository/i_appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl(this.remoteDataSource);
}
