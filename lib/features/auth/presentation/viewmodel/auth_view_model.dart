import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(ref.watch(authUseCaseProvider));
});

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.authUseCase) : super(AuthState.initial());

  final AuthUseCase authUseCase;

  void registerUser(AuthEntity auth) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(auth);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false);
        showMySnackBar(message: 'Registered');
      },
    );
  }

  void obscurePassword() {
    state = state.copyWith(isObscure: !state.isObscure);
  }
}
