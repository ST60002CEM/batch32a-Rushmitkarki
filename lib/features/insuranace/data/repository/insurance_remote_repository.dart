import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/insuranace/data/data_source/remote/insurance_remote_data_source.dart';
import 'package:final_assignment/features/insuranace/domain/entity/insurance_entity.dart';
import 'package:final_assignment/features/insuranace/domain/repository/i_insurance_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final insuranceRemoteRepositoryProvider = Provider<IInsuranceRepository>((ref) {
  return InsuranceRemoteRepository(ref.read(insuranceRemoteDataSourceProvider));
});

class InsuranceRemoteRepository implements IInsuranceRepository {
  final InsuranceRemoteDataSource insuranceRemoteDataSource;

  InsuranceRemoteRepository(this.insuranceRemoteDataSource);

  @override
  Future<Either<Failure, List<InsuranceEntity>>> getInsurance() {
    return insuranceRemoteDataSource.getInsurance();
  }
}
