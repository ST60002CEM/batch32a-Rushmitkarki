import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/auth/data/model/doctor_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRemoteDataSourceProvider = Provider<DoctorRemoteDataSource>((ref) {
  return DoctorRemoteDataSource(ref.watch(httpServiceProvider));
});
class DoctorRemoteDataSource {
  final Dio _dio;
  DoctorRemoteDataSource(this._dio);

  // get data from post with pagination
  Future<Either<Failure, List<DoctorApiModel>>> getDoctors(int page) async{
    try{
      final response = await _dio.get(
        ApiEndPoints.getDoctors,
        queryParameters: {
          '_page' : page,
          '_limit' : ApiEndPoints.paginationDoctors,
        },

      );
      final data = response.data as List;
      final doctors = data.map((e) => DoctorApiModel.fromJson(e)).toList();
      return Right(doctors);
    }on DioException catch(e){
      return Left(Failure(error: e.error.toString()));
    }

  }
}
