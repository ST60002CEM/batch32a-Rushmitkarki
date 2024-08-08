import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/usecases/appointment_usecase.dart';
import 'package:final_assignment/features/appointment/presentation/state/appointment_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentViewmodelProvider =
    StateNotifierProvider<AppointmentViewmodel, AppointmentState>((ref) {
  final appointmentUsecase = ref.watch(appointmentUsecaseProvider);
  return AppointmentViewmodel(appointmentUsecase: appointmentUsecase);
});

class AppointmentViewmodel extends StateNotifier<AppointmentState> {
  final AppointmentUsecase appointmentUsecase;

  AppointmentViewmodel({required this.appointmentUsecase})
      : super(AppointmentState.initial());

  Future<void> addAppointment(AppointmentEntity appointment) async {
    state = state.copyWith(isLoading: true);
    final result = await appointmentUsecase.addAppointment(appointment);
    result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
        );
        showMySnackBar(message: 'Appointment added successfully');
      },
    );
  }
}
