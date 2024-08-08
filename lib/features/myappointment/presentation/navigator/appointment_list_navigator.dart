import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/myappointment/presentation/view/appointment_list_view.dart';

class AppointmentListViewNavigator {}

mixin AppointmentListViewNavigatorRoute {
  void openAppointmentDetail() {
    NavigateRoute.pushRoute(const AppointmentListView());
  }
}
