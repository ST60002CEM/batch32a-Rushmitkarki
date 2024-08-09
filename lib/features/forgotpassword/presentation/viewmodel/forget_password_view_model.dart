import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/forgotpassword/presentation/state/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordViewModelProvider
    extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModelProvider({required this.authUseCase})
      : super(ForgotPasswordState.initial());

  final AuthUseCase authUseCase;

  Future<void> sendOtp({required String contact, required bool isPhone}) async {
    state = state.copyWith(isLoading: true);

    final data = await authUseCase.sendOtp(contact: contact, isPhone: isPhone);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: true);
        showMySnackBar(message: 'OTP Sent Successfully', color: Colors.green);
      },
    );
  }

  Future<void> verifyOtp({
    required String contact,
    required String otp,
    required String password,
    required bool isPhone,
  }) async {
    state = state.copyWith(isLoading: true);

    final data = await authUseCase.resetPassword(
      contact: contact,
      otp: otp,
      password: password,
      isPhone: isPhone,
    );
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error);
      },
      (r) {
        state = state.copyWith(
            isLoading: false, isSent: false, passwordChanged: true);
        showMySnackBar(
            message: 'Password Changed Successfully', color: Colors.green);
      },
    );
  }
}

// Define the provider
final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModelProvider, ForgotPasswordState>(
  (ref) {
    final authUseCase = ref.read(authUseCaseProvider);
    return ForgotPasswordViewModelProvider(authUseCase: authUseCase);
  },
);
