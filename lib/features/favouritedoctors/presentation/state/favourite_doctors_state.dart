

import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';

class FavouriteDoctorState {
  final bool isLoading;
  final List<FavouriteDoctor> favouriteDoctors;
  final String? error;

  FavouriteDoctorState({
    required this.isLoading,
    required this.favouriteDoctors,
    this.error,
  });

  factory FavouriteDoctorState.initial() => FavouriteDoctorState(
        isLoading: false,
        favouriteDoctors: [],
        error: null,
      );

  FavouriteDoctorState copyWith({
    bool? isLoading,
    List<FavouriteDoctor>? favouriteDoctors,
    String? error,
  }) {
    return FavouriteDoctorState(
      isLoading: isLoading ?? this.isLoading,
      favouriteDoctors: favouriteDoctors ?? this.favouriteDoctors,
      error: error ?? this.error,
    );
  }
}
