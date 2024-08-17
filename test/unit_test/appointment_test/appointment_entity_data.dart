import 'package:final_assignment/features/appointment/domain/entity/appointment_entity.dart';

class AppointmentEntityData {
  AppointmentEntityData._();

  static List<AppointmentEntity> getAppointmentEntityList() {
    return [
      AppointmentEntity(
        id: "1",
        patientName: "John Doe",
        email: "john.doe@example.com",
        appointmentDate: DateTime.now().subtract(Duration(days: 1)),
        phoneNumber: "+1234567890",
        appointmentDescription: "Regular check-up",
        status: "Scheduled",
      ),
      AppointmentEntity(
        id: "2",
        patientName: "Jane Smith",
        email: "jane.smith@example.com",
        appointmentDate: DateTime.now().add(Duration(days: 1)),
        phoneNumber: "+0987654321",
        appointmentDescription: "Consultation",
        status: "Pending",
      ),
      AppointmentEntity(
        id: "3",
        patientName: "Alice Johnson",
        email: "alice.johnson@example.com",
        appointmentDate: DateTime.now().add(Duration(days: 2)),
        phoneNumber: "+1122334455",
        appointmentDescription: "Follow-up",
        status: "Completed",
      ),
    ];
  }
}
