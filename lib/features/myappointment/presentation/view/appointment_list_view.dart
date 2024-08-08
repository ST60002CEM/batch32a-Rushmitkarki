import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../viewmodel/appointment_list_view_model.dart';

class AppointmentListView extends ConsumerWidget {
  const AppointmentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appointmentListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment List'),
      ),
      body: state.appointments.isEmpty
          ? const Center(child: Text('No appointments available'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Patient Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Action')),
                ],
                rows: state.appointments.map((appointment) {
                  return DataRow(
                    cells: [
                      DataCell(Text(appointment.patientName)),
                      DataCell(Text(appointment.email)),
                      DataCell(Text(DateFormat('MM/dd/yyyy')
                          .format(appointment.appointmentDate))),
                      DataCell(Text(appointment.phoneNumber)),
                      DataCell(Text(appointment.appointmentDescription)),
                      const DataCell(Text('')), // Added empty DataCell
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
