import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/appointment/data/model/appointment_model.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dto/get_appointment_dto.dart';

final appointmentRemoteDataSourceProvider =
    Provider<AppointmentRemoteDataSource>((ref) {
  return AppointmentRemoteDataSource(
      ref.watch(httpServiceProvider), ref.watch(userSharedPrefsProvider));
});

class AppointmentRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPreferences;

  AppointmentRemoteDataSource(this.dio, this.userSharedPreferences);

  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment) async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);

      final response = await dio.post(
        ApiEndPoints.createAppointment,
        data: AppointmentModel.fromEntity(appointment).toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        throw Exception('Failed to create appointment');
      }
    } catch (e) {
      return Left(Failure(error: 'Failed to create appointment: $e'));
    }
  }

  Future<Either<Failure, List<AppointmentEntity>>> fetchAppointments() async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);

      final response = await dio.get(
        ApiEndPoints.getUsersWithAppointments,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final appointmentDto = GetAppointmentDto.fromJson(response.data);
        return Right(AppointmentModel.toEntities(appointmentDto.data));
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }

//   cancel appointment
  Future<Either<Failure, bool>> cancelAppointment(String id) async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);

      final response = await dio.put(
        '${ApiEndPoints.cancelAppointment}/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        throw Exception('Failed to cancel appointment');
      }
    } catch (e) {
      return Left(Failure(error: 'Failed to cancel appointment: $e'));
    }
  }
}
