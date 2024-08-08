import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favouritedoctors/data/data_source/remote/favourite_doctor_remote_data_source.dart';
import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/domain/repository/i_favourite_doctors_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteDoctorRepositoryProvider = Provider<IFavouriteDoctorRepository>((ref) {
  return FavouriteDoctorRepository(ref.watch(favouriteDoctorRemoteDataSourceProvider));
});

class FavouriteDoctorRepository implements IFavouriteDoctorRepository {
  final FavouriteDoctorRemoteDataSource remoteDataSource;

  FavouriteDoctorRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, List<FavouriteDoctor>>> fetchFavouriteDoctors() {
    return remoteDataSource.fetchFavouriteDoctors();
  }
}
