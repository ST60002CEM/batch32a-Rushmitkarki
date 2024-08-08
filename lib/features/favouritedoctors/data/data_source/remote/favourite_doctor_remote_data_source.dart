import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/favouritedoctors/data/dto/favourite_doctors_dto.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final favouriteDoctorRemoteDataSourceProvider =
    Provider<FavouriteDoctorRemoteDataSource>(
  (ref) => FavouriteDoctorRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class FavouriteDoctorRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FavouriteDoctorRemoteDataSource(
      {required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<FavouriteEntity>>> fetchFavouriteDoctors() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(ApiEndPoints.getUserFavorites,options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));
      if (response.statusCode == 200) {
        final favouriteDoctors = FavouriteDoctorDto.fromJson(response.data).favorites;

        return Right(favouriteDoctors.map((e) => e.toEntity()).toList());
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

//   add doctor
  Future<Either<Failure, bool>> addFavouriteDoctor(String doctorId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(ApiEndPoints.addFavorite, data: {
        'doctorId': doctorId
      },options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));
      if (response.statusCode == 201) {
        return const Right(true);
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

//   remove doctor
  Future<Either<Failure, bool>> removeFavouriteDoctor(String doctorId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.delete(ApiEndPoints.deleteFavorite + doctorId
      ,options: Options(
        headers: {
          'Authorization': 'Bearer $token'
        }
      ));
      if (response.statusCode == 200) {
        return const Right(true);
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
