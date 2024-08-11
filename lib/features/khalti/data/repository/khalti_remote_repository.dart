import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/khalti/data/data_source/remote/khalti_remote_data_source.dart';
import 'package:final_assignment/features/khalti/domain/entity/khalti_entity.dart';
import 'package:final_assignment/features/khalti/domain/repository/i_khalti_repositroy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khaltiRemoteRepositoryProvider = Provider<IKhaltiRepository>((ref) {
  return KhaltiRemoteRepository(ref.read(khaltiRemoteDataSourceProvider));
});

class KhaltiRemoteRepository implements IKhaltiRepository {
  final KhaltiRemoteDataSource khaltiRemoteDataSource;

  KhaltiRemoteRepository(this.khaltiRemoteDataSource);

  @override
  Future<Either<Failure, bool>> completeKhalti(KhaltiEntity entity) {
    return khaltiRemoteDataSource.completeKhalti(entity);
  }

  @override
  Future<Either<Failure, String>> initializeKhalti(
      {required String itemId, required double totalPrice}) {
    return khaltiRemoteDataSource.initializeKhalti(
        itemId: itemId, totalPrice: totalPrice);
  }
}
