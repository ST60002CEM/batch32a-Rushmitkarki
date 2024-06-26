import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/model/doctor_api_model.dart';
import 'package:final_assignment/features/auth/domain/entity/doctor_entity.dart';

class DoctorRemoteDataSource {
  final Dio dio;
  final DoctorApiModel doctorApiModel;
  final UserSharedPrefs userSharedPrefs;

  DoctorRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    required this.doctorApiModel,
  });
  Future<Either<Failure, bool>> registerDoctor(DoctorEntity doctorEntity) async {
    try {
      Response response = await dio.post(
        ApiEndPoints.registerDoctor,
        data: doctorApiModel.fromEntity(doctorEntity).toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(
        Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
  
  
  
}
