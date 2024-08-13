import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/insuranace/domain/usecases/insurance_usecase.dart';
import 'package:final_assignment/features/insuranace/presentation/state/insurance_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../khalti/domain/usecases/khalti_usecase.dart';
import '../navigator/insurance_navigator.dart';

final insuranceViewModelProvider =
    StateNotifierProvider<InsuranceViewModel, InsuranceState>(
  (ref) => InsuranceViewModel(
    ref.read(insuranceUsecaseProvider),
    ref.read(khaltiUsecaseProvider),
    ref.read(insuranceNavigatorProvider),
  ),
);

class InsuranceViewModel extends StateNotifier<InsuranceState> {
  final InsuranceUsecase insuranceUsecase;
  final KhaltiUsecase khaltiUsecase;
  final InsuranceViewNavigator insuranceViewNavigator;

  InsuranceViewModel(
      this.insuranceUsecase, this.khaltiUsecase, this.insuranceViewNavigator)
      : super(InsuranceState.initial()) {
    getInsurance();
  }

  void getInsurance() async {
    state = state.copyWith(isLoading: true);
    final result = await insuranceUsecase.getInsurance();
    result.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (insurance) =>
          state = state.copyWith(isLoading: false, insurance: insurance),
    );
  }

  initializeKhalti(String itemId, double totalPrice) async {
    state = state.copyWith(isLoading: true);
    final data = await khaltiUsecase.initializeKhalti(
        itemId: itemId, totalPrice: totalPrice);
    data.fold((l) {
      state = state.copyWith(
        isLoading: false,
      );
      showMySnackBar(message: l.error);
    }, (r) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      insuranceViewNavigator.openKhaltiView(r);
    });
  }
}
