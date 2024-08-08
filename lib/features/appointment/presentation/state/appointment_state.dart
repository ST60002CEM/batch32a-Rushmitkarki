class AppoinymentState {
  final String? error;
  final bool isLoading;

  AppoinymentState({required this.error, required this.isLoading});

  factory AppoinymentState.initial() {
    return AppoinymentState(
      error: null,
      isLoading: false,
    );
  }

  AppoinymentState copyWith({
    String? error,
    bool? isLoading,
  }) {
    return AppoinymentState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
