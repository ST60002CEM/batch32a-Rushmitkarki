class KhaltiState {
  final bool isLoading;
  final String? error;

  KhaltiState({required this.isLoading, required this.error});

  factory KhaltiState.initial() {
    return KhaltiState(
      isLoading: false,
      error: null,
    );
  }

  KhaltiState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return KhaltiState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
