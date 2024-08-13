import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/khalti/presentation/view/khalti_pay_view.dart';

class KhaltiViewNavigator {}

mixin KhaltiViewRoute {
  void openKhaltiView(String pidx) {
    NavigateRoute.pushRoute(KhaltiSDKDemo(pidx: pidx));
  }
}
