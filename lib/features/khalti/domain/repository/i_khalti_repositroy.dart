import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/khalti/domain/entity/khalti_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khaltiRepositoryProvider = Provider<IKhaltiRepository>(
  (ref) {
    return ref.read(khaltiRepositoryProvider);
  },
);

abstract class IKhaltiRepository {
  Future<Either<Failure, List<KhaltiEntity>>> initializeKhalti();
}
