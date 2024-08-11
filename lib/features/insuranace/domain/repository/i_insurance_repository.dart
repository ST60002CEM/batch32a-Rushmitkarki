import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/insuranace/data/repository/insurance_remote_repository.dart';
import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final insuranceRepositoryProvider = Provider<IInsuranceRepository>(
  (ref) {
    return ref.read(insuranceRemoteRepositoryProvider);
  },
);

abstract class IInsuranceRepository {
  Future<Either<Failure, List<InsuranceEntity>>> getInsurance();
}
