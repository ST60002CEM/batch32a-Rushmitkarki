import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final homeViewModelProvider = StateNotifierProvider<HomeViewModel, int>(
  (ref) => HomeViewModel(ref.read(homeViewNavigatorProvider)),
);

class HomeViewModel extends StateNotifier<int> {
  HomeViewModel(this.homeNavigator) : super(0);

  final HomeViewNavigator homeNavigator;

  void changeIndex(int index) {
    state = index;
  }

  void logout() async {
    showMySnackBar(message: 'Logging out....', color: Colors.red);
    await Future.delayed(const Duration(seconds: 1));
    openLoginView();
  }

  void openLoginView() {
    homeNavigator.openLoginView();
  }
}
