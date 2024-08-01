import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/favouritedoctors/data/dto/favourite_doctors_dto.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteDoctorRemoteDataSourceProvider =
    Provider<FavouriteDoctorRemoteDataSource>(
  (ref) => FavouriteDoctorRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
  ),
);

class FavouriteDoctorRemoteDataSource {
  final Dio dio;

  FavouriteDoctorRemoteDataSource({required this.dio});

  Future<Either<Failure, List<FavouriteDoctor>>> fetchFavouriteDoctors() async {
    try {
      Response response = await dio.get(ApiEndPoints.getUserFavorites);
      if (response.statusCode == 200) {
        List<FavouriteDoctor> favouriteDoctors = (response.data as List)
            .map((doctor) => FavouriteDoctorDto.fromJson(doctor).toEntity())
            .toList();
        return Right(favouriteDoctors);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
