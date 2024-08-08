import 'package:final_assignment/features/myappointment/presentation/state/appointment_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../appointment/domain/usecases/appointment_usecase.dart';

final appointmentListViewModelProvider =
    StateNotifierProvider<AppointmentListViewModel, AppointmentListState>(
  (ref) {
    final appointmentUsecase = ref.watch(appointmentUsecaseProvider);
    return AppointmentListViewModel(appointmentUsecase: appointmentUsecase);
  },
);

class AppointmentListViewModel extends StateNotifier<AppointmentListState> {
  final AppointmentUsecase appointmentUsecase;

  AppointmentListViewModel({required this.appointmentUsecase})
      : super(AppointmentListState.initial()) {
    getAppointments();
  }

  Future<void> getAppointments() async {
    state = state.copyWith(isLoading: true);
    final result = await appointmentUsecase.getAppointments();
    result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
          appointments: r,
        );
      },
    );
  }
}
