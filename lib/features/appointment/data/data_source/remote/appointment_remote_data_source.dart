import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/appointment/data/model/appointment_model.dart';

class AppointmentRemoteDataSource {
  final Dio dio;

  AppointmentRemoteDataSource(this.dio);

  Future<void> createAppointment(AppointmentModel appointment) async {
    try {
      final response = await dio.post(ApiEndPoints.createAppointment,
          data: appointment.toJson());
      if (response.statusCode != 201) {
        throw Exception('Failed to create appointment');
      }
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  Future<List<AppointmentModel>> fetchAppointments() async {
    try {
      final response = await dio.get(ApiEndPoints.getUsersWithAppointments);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => AppointmentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }
}
