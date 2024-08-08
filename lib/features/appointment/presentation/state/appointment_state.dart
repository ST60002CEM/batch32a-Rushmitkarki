class AppointmentState {
  final String? error;
  final bool isLoading;

  AppointmentState({required this.error, required this.isLoading});

  factory AppointmentState.initial() {
    return AppointmentState(
      error: null,
      isLoading: false,
    );
  }

  AppointmentState copyWith({
    String? error,
    bool? isLoading,
  }) {
    return AppointmentState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
