import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/khalti/data/model/khalti_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/failure/failure.dart';
import '../../../domain/entity/khalti_entity.dart';

final khaltiRemoteDataSourceProvider = Provider<KhaltiRemoteDataSource>((ref) {
  return KhaltiRemoteDataSource(ref.read(httpServiceProvider));
});

class KhaltiRemoteDataSource {
  final Dio dio;

  KhaltiRemoteDataSource(this.dio);

  Future<Either<Failure, String>> initializeKhalti(
      {required String itemId, required double totalPrice}) async {
    try {
      final response = await dio.post(ApiEndPoints.khalti,
          data: {'itemId': itemId, 'totalPrice': totalPrice * 100});
      if (response.statusCode == 200) {
        return Right(response.data['pidx']);
      } else {
        return Left(Failure(error: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      print(e);
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> completeKhalti(KhaltiEntity entity) async {
    try {
      final response = await dio.get(ApiEndPoints.completepayment,
          queryParameters: KhaltiApiModel.froEntity(entity).toJson());
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(error: response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    } catch (e) {
      print(e);
      return Left(Failure(error: e.toString()));
    }
  }
}
