import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/provider/theme_provider.dart';
import 'package:final_assignment/features/home/presentation/view/mycard.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/doctor_view_model.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final List<String> carouselItems = [
    'assets/images/sideimage1.png',
    'assets/images/sideimage2.jpg',
    'assets/images/sideimage4.png',
  ];

  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  final List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void initState() {
    super.initState();
    // Uncomment and modify this if you want to use gyroscope functionality
    // _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
    //   setState(() {
    //     _gyroscopeValues = <double>[event.x, event.y, event.z];
    //     _checkGyroscopeValues(_gyroscopeValues);
    //   });
    // }));
  }

  void _checkGyroscopeValues(List<double> values) async {
    const double threshold = 5;
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          title: 'Logout',
          desc: 'Are You Sure You Want To Logout?',
          btnOkOnPress: () {
            ref.read(profileViewmodelProvider.notifier).logout();
          },
          btnCancelOnPress: () {},
        ).show();

        isDialogShowing = false;
        if (result == true) {
          showMySnackBar(
            message: 'Logged Out Successfully!',
            color: Colors.green,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorState = ref.watch(doctorViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.greenAccent,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: carouselItems
                    .map((item) => Container(
                          child: Center(
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 1000),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text('Doctors List',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: doctorState.doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctorState.doctors[index];
                    return MyCard(
                      title: doctor.doctorName,
                      subtitle: doctor.doctorField,
                      imageUrl:
                          '${ApiEndPoints.doctorImageUrl}${doctor.doctorImage}',
                      onFavoritePressed: () {
                        ref
                            .read(doctorViewModelProvider.notifier)
                            .favorite(doctor.doctorid);
                      },
                    );
                  },
                ),
              ),
              if (doctorState.isLoading) const CircularProgressIndicator(),
              if (doctorState.error.isNotEmpty)
                Text(
                  doctorState.error,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }
}
