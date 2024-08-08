import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart';


abstract class IFavouriteDoctorRepository {
  Future<Either<Failure, List<FavouriteEntity>>> fetchFavouriteDoctors();

  Future<Either<Failure, bool>> addFavouriteDoctor(String doctorId);

  Future<Either<Failure, bool>> removeFavouriteDoctor(String doctorId);
}
