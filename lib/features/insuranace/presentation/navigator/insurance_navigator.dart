import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/insuranace/presentation/view/insurance_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../khalti/presentation/navigator/khalti_navigator.dart';

final insuranceNavigatorProvider = Provider(
  (ref) => InsuranceViewNavigator(),
);

class InsuranceViewNavigator with KhaltiViewRoute {}

mixin InsuranceNavigatorRoute {
  void navigateToInsuranceView() {
    NavigateRoute.pushRoute(const InsuranceView());
  }
}
