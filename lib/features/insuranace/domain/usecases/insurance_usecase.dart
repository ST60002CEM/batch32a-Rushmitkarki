import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';
import 'package:final_assignment/features/insuranace/domain/repository/i_insurance_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final insuranceUsecaseProvider = Provider(
  (ref) => InsuranceUsecase(
    insuranceRepository: ref.read(insuranceRepositoryProvider),
  ),
);

class InsuranceUsecase {
  final IInsuranceRepository insuranceRepository;

  InsuranceUsecase({
    required this.insuranceRepository,
  });

  Future<Either<Failure, List<InsuranceEntity>>> getInsurance() {
    return insuranceRepository.getInsurance();
  }
}
