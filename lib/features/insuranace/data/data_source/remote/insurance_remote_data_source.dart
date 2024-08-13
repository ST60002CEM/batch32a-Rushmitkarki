import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/insuranace/data/dto/insurance_dto.dart';
import 'package:final_assignment/features/insuranace/data/model/insurance_api_model.dart';
import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final insuranceRemoteDataSourceProvider = Provider<InsuranceRemoteDataSource>(
  (ref) => InsuranceRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(insuranceApiModelProvider),
  ),
);

class InsuranceRemoteDataSource {
  final Dio _dio;
  final InsuranceApiModel insuranceApiModel;

  InsuranceRemoteDataSource(this._dio, this.insuranceApiModel);

  Future<Either<Failure, List<InsuranceEntity>>> getInsurance() async {
    try {
      final response = await _dio.get(ApiEndPoints.getInsurance);
      final insuranceDto = InsuranceDto.fromJson(response.data);
      final insuranceList = insuranceDto.data.map((e) => e.toEntity()).toList();
      return Right(insuranceList);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
