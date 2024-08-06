import 'package:final_assignment/features/forgotpassword/presentation/view/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final forgotPasswordNavigatorProvider =
    Provider<ForgotPasswordViewNavigator>((ref) => ForgotPasswordViewNavigator());

class ForgotPasswordViewNavigator {
  void openForgotPasswordView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }
}
