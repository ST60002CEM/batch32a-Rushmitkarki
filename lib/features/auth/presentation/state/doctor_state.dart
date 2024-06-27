import 'package:final_assignment/features/auth/data/model/doctor_api_model.dart';

class DoctorState {
  final List<DoctorApiModel> doctors;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  DoctorState({
    required this.doctors,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });
  factory DoctorState.initial() {
    return DoctorState(
      doctors: [],
      hasReachedMax: false,
      page: 1,
      isLoading: false,
    );
  }
  DoctorState copyWith({
    List<DoctorApiModel>? doctors,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return DoctorState(
      doctors: doctors ?? this.doctors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
