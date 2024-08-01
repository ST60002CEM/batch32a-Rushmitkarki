import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/appointment/data/model/appointment_model.dart';

class AppointmentListRemoteDataSource {
  final Dio dio;

  AppointmentListRemoteDataSource(this.dio);

  Future<List<AppointmentModel>> fetchUserAppointments() async {
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
