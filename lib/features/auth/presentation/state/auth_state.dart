class AuthState {
  final bool isLoading;
  final bool isObscure;
  final String? error;

  AuthState({
    required this.isLoading,
    required this.isObscure,
    this.error,
  });

  factory AuthState.initial() => AuthState(
        isLoading: false,
        isObscure: true,
        error: null,
      );

  AuthState copyWith({
    bool? isLoading,
    bool? isObscure,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isObscure: isObscure ?? this.isObscure,
      error: error ?? this.error,
    );
  }
}
