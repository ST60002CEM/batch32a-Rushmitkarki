import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/khalti/domain/repository/i_khalti_repositroy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khaltiUsecaseProvider = Provider(
  (ref) => KhaltiUsecase(
    khaltiRepository: ref.read(ikhaltiRepositoryProvider),
  ),
);

class KhaltiUsecase {
  final IKhaltiRepository khaltiRepository;

  KhaltiUsecase({
    required this.khaltiRepository,
  });

  Future<Either<Failure, String>> initializeKhalti(
      {required String itemId, required double totalPrice}) {
    return khaltiRepository.initializeKhalti(
      itemId: itemId,
      totalPrice: totalPrice,
    );
  }
}
