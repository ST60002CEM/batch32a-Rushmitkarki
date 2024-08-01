import 'package:final_assignment/features/myappointment/presentation/viewmodel/appointment_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AppointmentListView extends ConsumerWidget {
  const AppointmentListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment List'),
      ),
      body: appointments.isEmpty
          ? const Center(child: Text('No appointments available'))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Patient Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Description')),
                ],
                rows: appointments.map((appointment) {
                  return DataRow(
                    cells: [
                      DataCell(Text(appointment.id)),
                      DataCell(Text(appointment.patientName)),
                      DataCell(Text(appointment.email)),
                      DataCell(Text(DateFormat('MM/dd/yyyy')
                          .format(appointment.appointmentDate))),
                      DataCell(Text(appointment.phoneNumber)),
                      DataCell(Text(appointment.appointmentDescription)),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
