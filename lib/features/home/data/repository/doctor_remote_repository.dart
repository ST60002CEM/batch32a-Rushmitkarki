import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/repository/i_doctor_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRemoteRepositoryProvider = Provider<IDoctorRepository>((ref) {
  return DoctorRemoteRepository(
      doctorRemoteDataSource: ref.watch(doctorRemoteDataSourceProvider));
});

class DoctorRemoteRepository implements IDoctorRepository {
  final DoctorRemoteDataSource doctorRemoteDataSource;

  DoctorRemoteRepository({required this.doctorRemoteDataSource});
  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() {
    // TODO: implement getAllDoctors
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> paginateDoctors(
      int page, int limit) {
    return doctorRemoteDataSource.pagination(page, limit);
  }
}
