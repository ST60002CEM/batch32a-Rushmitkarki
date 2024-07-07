import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/provider/theme_provider.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            if (doctorState.hasReachedMax) {
              showMySnackBar(message: 'No more data', color: Colors.red);
              return false;
            }

            ref.read(doctorViewModelProvider.notifier).getDoctors();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard '),
          actions: [
            IconButton(
              onPressed: () {
                showMySnackBar(message: 'REF');
                ref.read(doctorViewModelProvider.notifier).resetState();
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
              value: ref.read(themeViewModelProvider),
              onChanged: (value) {
                ref.read(themeViewModelProvider.notifier).changeTheme();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            color: Colors.greenAccent,
            backgroundColor: Colors.blueAccent,
            onRefresh: () async {
              ref.read(doctorViewModelProvider.notifier).resetState();
            },
            child: Column(
              children: [
                const Text('Doctors List'),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: doctorState.doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctorState.doctors[index];
                      return SizedBox(
                        height: 100,
                        child: ListTile(
                          title: Text(doctor.doctorName),
                          subtitle: Text(doctor.doctorField),
                          leading: doctor.doctorImage.isNotEmpty
                              ? Image.network(
                                  '${ApiEndPoints.doctorImageUrl}${doctor.doctorImage}')
                              : null,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  ),
                ),
                if (doctorState.isLoading) ...{
                  const CircularProgressIndicator(),
                } else if (doctorState.error.isNotEmpty)
                  Text(
                    doctorState.error,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
