import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';


abstract class IFavouriteDoctorRepository {
  Future<Either<Failure, List<FavouriteDoctor>>> fetchFavouriteDoctors();
}
