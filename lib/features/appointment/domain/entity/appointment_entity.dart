
class Appointment {
  final String id;
  final String patientName;
  final String email;
  final DateTime appointmentDate;
  final String phoneNumber;
  final String appointmentDescription;

  Appointment({
    required this.id,
    required this.patientName,
    required this.email,
    required this.appointmentDate,
    required this.phoneNumber,
    required this.appointmentDescription,
  });
}
