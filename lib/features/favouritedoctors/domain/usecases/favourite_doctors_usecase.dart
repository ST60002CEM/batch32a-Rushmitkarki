import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/data/repository/favourit_doctor_repository.dart';
import 'package:final_assignment/features/favouritedoctors/domain/repository/i_favourite_doctors_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchFavouriteDoctorsUseCaseProvider = Provider<FetchFavouriteDoctorsUseCase>((ref) {
  return FetchFavouriteDoctorsUseCase(ref.watch(favouriteDoctorRepositoryProvider));
});

class FetchFavouriteDoctorsUseCase {
  final IFavouriteDoctorRepository repository;

  FetchFavouriteDoctorsUseCase(this.repository);

  Future<Either<Failure, List<FavouriteDoctor>>> call() {
    return repository.fetchFavouriteDoctors();
  }
}
