import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/appointment/data/dto/appointment_dto.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';


abstract class AppointmentRemoteDataSource {
  Future<Appointment> getAppointment(String appointmentId);
  Future<List<Appointment>> getUsersWithAppointments();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final Dio dio;

  AppointmentRemoteDataSourceImpl(this.dio);

  @override
  Future<Appointment> getAppointment(String appointmentId) async {
    final response = await dio.get('${ApiEndPoints.baseUrl}${ApiEndPoints.getAppointmentById}$appointmentId');
    if (response.statusCode == 200) {
      return AppointmentModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load appointment');
    }
  }

  @override
  Future<List<Appointment>> getUsersWithAppointments() async {
    final response = await dio.get('${ApiEndPoints.baseUrl}${ApiEndPoints.getUsersWithAppointments}');
    if (response.statusCode == 200) {
      final appointments = (response.data['data'] as List)
          .map((json) => AppointmentModel.fromJson(json))
          .toList();
      return appointments;
    } else {
      throw Exception('Failed to load appointments');
    }
  }
}
