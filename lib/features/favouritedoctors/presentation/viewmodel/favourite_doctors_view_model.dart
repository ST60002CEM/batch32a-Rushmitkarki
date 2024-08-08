
import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart';
import 'package:final_assignment/features/favouritedoctors/presentation/state/favourite_doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/show_my_snackbar.dart';

final favouriteDoctorViewModelProvider =
    StateNotifierProvider<FavouriteDoctorViewModel, FavouriteDoctorState>((ref) {
  return FavouriteDoctorViewModel(ref.watch(fetchFavouriteDoctorsUseCaseProvider));
});

class FavouriteDoctorViewModel extends StateNotifier<FavouriteDoctorState> {
  final FavouriteDoctorsUseCase fetchFavouriteDoctorsUseCase;

  FavouriteDoctorViewModel(this.fetchFavouriteDoctorsUseCase) : super(FavouriteDoctorState.initial());

  Future<void> fetchFavouriteDoctors() async {
    state = state.copyWith(isLoading: true);
    final result = await fetchFavouriteDoctorsUseCase();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (favouriteDoctors) {
        state = state.copyWith(isLoading: false, favouriteDoctors: favouriteDoctors);
      },
    );
  }

   removeFavouriteDoctor(String s) async {
     final result = await fetchFavouriteDoctorsUseCase.removeFavouriteDoctor(s);
     result.fold(
       (failure) {
         showMySnackBar(message: failure.error, color: Colors.red);
       },
       (data) {
         fetchFavouriteDoctors();
         showMySnackBar(message: 'Removed from Favourites', color: Colors.red);
       },
     );
    fetchFavouriteDoctors();
   }
}
