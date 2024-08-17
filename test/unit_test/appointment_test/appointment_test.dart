import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';
import 'package:final_assignment/features/appointment/domain/usecases/appointment_usecase.dart';
import 'package:final_assignment/features/appointment/presentation/viewmodel/appointment_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'appointment_test.mocks.dart';

// Generate mocks
@GenerateNiceMocks([
  MockSpec<AppointmentUsecase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockAppointmentUsecase mockAppointmentUsecase;
  late ProviderContainer container;

  setUp(() {
    mockAppointmentUsecase = MockAppointmentUsecase();

    container = ProviderContainer(
      overrides: [
        appointmentViewmodelProvider.overrideWith(
          (ref) =>
              AppointmentViewmodel(appointmentUsecase: mockAppointmentUsecase),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('AppointmentViewmodel addAppointment success test', () async {
    // Mock data for addAppointment
    final appointment = AppointmentEntity(
      id: "1",
      patientName: "John Doe",
      email: "john.doe@example.com",
      appointmentDate: DateTime.now(),
      phoneNumber: "+1234567890",
      appointmentDescription: "Regular check-up",
      status: "Scheduled",
    );

    // Mock successful response
    when(mockAppointmentUsecase.addAppointment(appointment))
        .thenAnswer((_) async => Future.value(Right(true)));

    final appointmentViewmodel =
        container.read(appointmentViewmodelProvider.notifier);

    // Explicitly call addAppointment
    await appointmentViewmodel.addAppointment(appointment);

    expect(container.read(appointmentViewmodelProvider).isLoading, isFalse);
    expect(container.read(appointmentViewmodelProvider).error, isNull);

    // Verify that the success message was shown
    // Note: Mocking showMySnackBar to verify if it was called
    // Use a mock for showMySnackBar function or check the side effect if necessary
  });

  test('AppointmentViewmodel addAppointment failure test', () async {
    // Mock data for addAppointment
    final appointment = AppointmentEntity(
      id: "1",
      patientName: "John Doe",
      email: "john.doe@example.com",
      appointmentDate: DateTime.now(),
      phoneNumber: "+1234567890",
      appointmentDescription: "Regular check-up",
      status: "Scheduled",
    );

    // Mock failure response
    final failure = Failure(error: 'Failed to add appointment');
    when(mockAppointmentUsecase.addAppointment(appointment))
        .thenAnswer((_) async => Future.value(Left(failure)));

    final appointmentViewmodel =
        container.read(appointmentViewmodelProvider.notifier);

    // Explicitly call addAppointment
    await appointmentViewmodel.addAppointment(appointment);

    expect(container.read(appointmentViewmodelProvider).isLoading, isFalse);
    expect(container.read(appointmentViewmodelProvider).error,
        equals('Failed to add appointment'));

    // Verify that no success message was shown
    // Note: As with the success case, mock showMySnackBar or check the side effect if necessary
  });
}
