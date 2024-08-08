import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/forgotpassword/presentation/state/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>((ref) {
  return ForgotPasswordViewModel(
    authUseCase: ref.watch(authUseCaseProvider),
  );
});

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel({
    required this.authUseCase,
  }) : super(ForgotPasswordState.initial());

  final AuthUseCase authUseCase;

  sendOtp(String phoneNumber) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.sendOtp(phoneNumber);
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

  verifyOtp(String otp, String phone, String password) async {
    state = state.copyWith(isLoading: true);

    var data = await authUseCase.resetPass(
      phone: phone,
      password: password,
      otp: otp,
    );
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, isSent: false);

        showMySnackBar(
            message: 'Password Changed Successfully', color: Colors.green);
      },
    );
  }
}
