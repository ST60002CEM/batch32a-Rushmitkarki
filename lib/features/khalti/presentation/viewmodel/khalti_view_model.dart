import 'package:final_assignment/features/khalti/domain/usecases/khalti_usecase.dart';
import 'package:final_assignment/features/khalti/presentation/state/khalti_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KhaltiViewModel extends StateNotifier<KhaltiState> {
  KhaltiViewModel({required this.khaltiUsecase}) : super(KhaltiState.initial());

  final KhaltiUsecase khaltiUsecase;
}
