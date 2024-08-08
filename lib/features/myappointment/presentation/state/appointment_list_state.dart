import '../../../appointment/domain/entity/appointment_entity.dart';

class AppointmentState {
  final String? error;
  final bool isLoading;
  final List<AppointmentEntity> appointments;

  AppointmentState(
      {required this.error,
      required this.isLoading,
      required this.appointments});

  factory AppointmentState.initial() {
    return AppointmentState(
      error: null,
      isLoading: false,
      appointments: [],
    );
  }

  AppointmentState copyWith({
    String? error,
    bool? isLoading,
    List<AppointmentEntity>? appointments,
  }) {
    return AppointmentState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      appointments: appointments ?? this.appointments,
    );
  }
}
