import 'package:final_assignment/features/home/data/model/doctor_api_model.dart';
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart';

class DoctorState {
  final List<DoctorEntity> doctors;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final String error;

  DoctorState({
    required this.doctors,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    required this.error,
  });
  factory DoctorState.initial() {
    return DoctorState(
      doctors: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      error: '',
    );
  }
  DoctorState copyWith({
    List<DoctorEntity>? doctors,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    String? error,
  }) {
    return DoctorState(
      doctors: doctors ?? this.doctors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
