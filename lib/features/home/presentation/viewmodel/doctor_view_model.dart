import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart';
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart';
import 'package:final_assignment/features/home/presentation/state/doctor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorViewModelProvider =
    StateNotifierProvider<DoctorViewModel, DoctorState>(
  (ref) {
    final doctorUsecase = ref.read(doctorUsecaseProvider);
    final favouriteUsecase = ref.read(fetchFavouriteDoctorsUseCaseProvider);
    return DoctorViewModel(doctorUsecase, favouriteUsecase);
  },
);

class DoctorViewModel extends StateNotifier<DoctorState> {
  final DoctorUsecase _doctorUsecase;
  final FavouriteDoctorsUseCase _favouriteUsecase;

  DoctorViewModel(this._doctorUsecase, this._favouriteUsecase)
      : super(DoctorState.initial()) {
    getDoctors();
  }

  Future<void> resetState() async {
    state = DoctorState.initial();
    await getDoctors();
  }

  Future<void> getDoctors() async {
    if (state.hasReachedMax || state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final page = state.page + 1;

    final result = await _doctorUsecase.paginateDoctors(page, 10, '');
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

  favorite(String? doctorid) async {
    final result = await _favouriteUsecase.addFavouriteDoctor(doctorid!);
    result.fold(
      (failure) {
        // showMySnackBar(message: failure.error, color: Colors.red);
      },
      (data) {
        showMySnackBar(
            message: 'Doctor added to favorite', color: Colors.green);
      },
    );
  }
}
