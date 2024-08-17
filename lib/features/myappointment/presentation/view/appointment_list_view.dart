import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../viewmodel/appointment_list_view_model.dart';

class AppointmentListView extends ConsumerStatefulWidget {
  const AppointmentListView({super.key});

  @override
  ConsumerState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends ConsumerState<AppointmentListView> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(appointmentListViewModelProvider.notifier).getAppointments();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment List'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.appointments.isEmpty
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
                          DataColumn(label: Text('Status')),
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
                              DataCell(
                                  Text(appointment.appointmentDescription)),
                              DataCell(Text(appointment.status ?? 'N/A')),
                              DataCell(
                                appointment.status == 'canceled'
                                    ? const Text('Canceled')
                                    : IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Cancel Appointment'),
                                                content: const Text(
                                                    'Are you sure you want to cancel this appointment?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('No'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Yes'),
                                                    onPressed: () {
                                                      ref
                                                          .read(
                                                              appointmentListViewModelProvider
                                                                  .notifier)
                                                          .cancelAppointment(
                                                              appointment.id!);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
    );
  }
}
