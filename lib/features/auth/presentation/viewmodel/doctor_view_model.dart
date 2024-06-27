import 'package:final_assignment/features/auth/data/data_source/remote/doctor_remote_data_source.dart';
import 'package:final_assignment/features/auth/presentation/state/doctor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorViewModelProvider =
    StateNotifierProvider<DoctorViewModel, DoctorState>(
  (ref) {
    final doctorRemoteDataSource = ref.read(doctorRemoteDataSourceProvider);
    return DoctorViewModel(doctorRemoteDataSource);
  },
);

class DoctorViewModel extends StateNotifier<DoctorState> {
  final DoctorRemoteDataSource _doctorRemoteDataSource;
  DoctorViewModel(this._doctorRemoteDataSource)
      : super(
          DoctorState.initial(),
        ) {
    getDoctors();
  }
  Future resetState() async {
    state = DoctorState.initial();
    getDoctors();
  }

  Future getDoctors() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final doctors = currentState.doctors;
    final hasReachedMax = currentState.hasReachedMax;
    if (hasReachedMax) {
      // get data from data source
      final result = await _doctorRemoteDataSource.getDoctors(page);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              isLoading: false,
              doctors: [...doctors, ...data],
              page: page,
            );
          }
        },
      );
    }
  }
}
