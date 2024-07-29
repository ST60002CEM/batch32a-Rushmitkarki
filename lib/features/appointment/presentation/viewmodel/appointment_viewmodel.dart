import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/usecases/appointment_usecase.dart';
import 'package:flutter/foundation.dart';


class AppointmentProvider extends ChangeNotifier {
  final GetAppointmentUseCase _getAppointmentUseCase;

  AppointmentProvider(this._getAppointmentUseCase);

  Appointment? _currentAppointment;
  Appointment? get currentAppointment => _currentAppointment;

  Future<void> loadAppointment(String appointmentId) async {
    final result = await _getAppointmentUseCase(appointmentId);
    result.fold(
      (failure) => print('Error: $failure'),
      (appointment) {
        _currentAppointment = appointment;
        notifyListeners();
      },
    );
  }
}
