import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/forgotpassword/presentation/navigator/forget_password_navigator.dart';
import 'package:final_assignment/features/forgotpassword/presentation/view/forget_password_view.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator
    with RegisterViewRoute, ForgotPasswordViewRoute, HomeViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }

  openForgotPasswordView() {
    NavigateRoute.popAndPushRoute(const ForgetPasswordView());
  }
}
