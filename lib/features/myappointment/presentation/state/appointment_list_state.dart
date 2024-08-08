import '../../../appointment/domain/entity/appointment_entity.dart';

class AppointmentListState {
  final String? error;
  final bool isLoading;
  final List<AppointmentEntity> appointments;

  AppointmentListState(
      {required this.error,
      required this.isLoading,
      required this.appointments});

  factory AppointmentListState.initial() {
    return AppointmentListState(
      error: null,
      isLoading: false,
      appointments: [],
    );
  }

  AppointmentListState copyWith({
    String? error,
    bool? isLoading,
    List<AppointmentEntity>? appointments,
  }) {
    return AppointmentListState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      appointments: appointments ?? this.appointments,
    );
  }
}
