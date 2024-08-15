import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/home/data/dto/doctor_dto.dart';
import 'package:final_assignment/features/home/data/model/doctor_api_model.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRemoteDataSourceProvider = Provider<DoctorRemoteDataSource>((ref) {
  return DoctorRemoteDataSource(
      ref.watch(httpServiceProvider), ref.watch(doctorApiModelProvider));
});

class DoctorRemoteDataSource {
  final Dio _dio;
  final DoctorApiModel doctorApiModel;

  DoctorRemoteDataSource(this._dio, this.doctorApiModel);

  // get data from post with pagination
  Future<Either<Failure, List<DoctorEntity>>> pagination(
      int page, int limit, String search) async {
    try {
      final response = await _dio.get(
        ApiEndPoints.paginationDoctors,
        queryParameters: {
          'page': page,
          'limit': limit,
          'search': search,
        },
      );
      final data = DoctorDto.fromJson(response.data).doctors;
      final doctors = doctorApiModel.toEntityList(data);
      return Right(doctors);
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
      ));
    }
  }
}
