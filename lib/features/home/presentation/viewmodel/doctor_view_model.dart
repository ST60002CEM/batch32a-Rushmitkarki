import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorViewModelProvider =
    StateNotifierProvider<DoctorViewModel, DoctorState>(
  (ref) {
    final doctorUsecase = ref.read(doctorUsecaseProvider);
    return DoctorViewModel(doctorUsecase);
  },
);

class DoctorViewModel extends StateNotifier<DoctorState> {
  final DoctorUsecase _doctorUsecase;

  DoctorViewModel(this._doctorUsecase) : super(DoctorState.initial());

  Future<void> resetState() async {
    state = DoctorState.initial();
    await getDoctors();
  }

  Future<void> getDoctors() async {
    if (state.hasReachedMax || state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await _doctorUsecase.paginateDoctors(page, 6);
    result.fold(
      (failure) {
        state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        );
        // showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(
            isLoading: false,
            doctors: [...state.doctors, ...data],
            page: page,
          );
        }
      },
    );
  }
}
