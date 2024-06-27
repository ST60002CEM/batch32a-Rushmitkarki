import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/repository/doctor_remote_repository.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRepositoryProvider = Provider<IDoctorRepository>((ref) {
  return (ref.read(doctorRemoteRepositoryProvider));
});

abstract class IDoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();
  Future<Either<Failure, List<DoctorEntity>>> paginateDoctors(
      int page, int limit);
}
