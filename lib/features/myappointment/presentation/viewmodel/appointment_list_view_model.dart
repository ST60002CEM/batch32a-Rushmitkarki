import 'package:final_assignment/core/provider/appointment_provider.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/myappointment/domain/usecases/fetch_user_appointment_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentListNotifier extends StateNotifier<List<Appointment>> {
  final FetchUserAppointments fetchUserAppointments;

  AppointmentListNotifier(this.fetchUserAppointments) : super([]) {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    try {
      final appointments = await fetchUserAppointments.call();
      state = appointments;
    } catch (e) {
      // Handle the error (e.g., show a message to the user)
    }
  }
}

final appointmentListProvider =
    StateNotifierProvider<AppointmentListNotifier, List<Appointment>>((ref) {
  final fetchUserAppointments = ref.watch(fetchUserAppointmentsProvider);
  return AppointmentListNotifier(fetchUserAppointments);
});
