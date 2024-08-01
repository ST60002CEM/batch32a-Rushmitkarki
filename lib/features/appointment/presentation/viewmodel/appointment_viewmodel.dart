import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/usecases/appointment_usecase.dart';
import 'package:final_assignment/features/appointment/domain/usecases/get_user_appointment_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentNotifier extends StateNotifier<List<Appointment>> {
  final FetchAppointments fetchAppointments;
  final CreateAppointment createAppointment;

  AppointmentNotifier(this.fetchAppointments, this.createAppointment) : super([]);

  Future<void> loadAppointments() async {
    try {
      final appointments = await fetchAppointments();
      state = appointments;
    } catch (e) {
      // Handle the error (e.g., show a message to the user)
    }
  }

  Future<void> addAppointment(Appointment appointment) async {
    try {
      await createAppointment(appointment);
      await loadAppointments(); // Refresh the list after adding a new appointment
    } catch (e) {
      // Handle the error (e.g., show a message to the user)
    }
  }
}
