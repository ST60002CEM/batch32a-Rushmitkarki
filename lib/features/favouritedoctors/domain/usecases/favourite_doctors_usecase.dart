import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/data/repository/favourite_doctor_repository.dart';
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart';
import 'package:final_assignment/features/favouritedoctors/domain/repository/i_favourite_doctors_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchFavouriteDoctorsUseCaseProvider = Provider<FavouriteDoctorsUseCase>((ref) {
  return FavouriteDoctorsUseCase(ref.watch(favouriteDoctorRepositoryProvider));
});

class FavouriteDoctorsUseCase {
  final IFavouriteDoctorRepository repository;

  FavouriteDoctorsUseCase(this.repository);

  Future<Either<Failure, List<FavouriteEntity>>> call() {
    return repository.fetchFavouriteDoctors();
  }

  Future<Either<Failure, bool>> addFavouriteDoctor(String doctorId) {
    return repository.addFavouriteDoctor(doctorId);
  }

  Future<Either<Failure, bool>> removeFavouriteDoctor(String doctorId) {
    return repository.removeFavouriteDoctor(doctorId);
  }
}
