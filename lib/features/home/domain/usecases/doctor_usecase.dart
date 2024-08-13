import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';
import 'package:final_assignment/features/home/domain/repository/i_doctor_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorUsecaseProvider = Provider(
  (ref) => DoctorUsecase(
    doctorRepository: ref.read(
      doctorRepositoryProvider,
    ),
  ),
);

class DoctorUsecase {
  final IDoctorRepository doctorRepository;

  DoctorUsecase({
    required this.doctorRepository,
  });

  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() {
    return doctorRepository.getAllDoctors();
  }

  Future<Either<Failure, List<DoctorEntity>>> paginateDoctors(
      int page, int limit) {
    return doctorRepository.paginateDoctors(page, limit);
  }
}
