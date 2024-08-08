

import 'package:final_assignment/features/favouritedoctors/data/model/favourite_doctors_model.dart';
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart';

class FavouriteDoctorState {
  final bool isLoading;
  final List<FavouriteEntity> favouriteDoctors;
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
    List<FavouriteEntity>? favouriteDoctors,
    String? error,
  }) {
    return FavouriteDoctorState(
      isLoading: isLoading ?? this.isLoading,
      favouriteDoctors: favouriteDoctors ?? this.favouriteDoctors,
      error: error ?? this.error,
    );
  }
}
