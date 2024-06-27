// lib/features/auth/presentation/view/dashboard_view.dart

import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  late bool isDark;

  @override
  void initState() {
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard '),
        actions: [
          IconButton(
            onPressed: () {
              showMySnackBar(message: 'Refreshing...');
              ref.read(doctorViewModelProvider.notifier).getDoctors();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.greenAccent,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(homeViewModelProvider.notifier).logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          Switch(
            value: isDark,
            onChanged: (value) {
              setState(() {
                isDark = value;
              });
            },
          ),
        ],
      ),
      body: doctorState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: doctorState.doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctorState.doctors[index];
                return ListTile(
                  title: Text(doctor.doctorName),
                  subtitle: Text(doctor.doctorField),
                  leading: doctor.doctorImage.isNotEmpty
                      ? Image.network(doctor.doctorImage)
                      : null,
                );
              },
            ),
    );
  }
}
