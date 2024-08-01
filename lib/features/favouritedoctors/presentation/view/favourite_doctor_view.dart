import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/favouritedoctors/presentation/viewmodel/favourite_doctors_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteDoctorView extends ConsumerStatefulWidget {
  const FavouriteDoctorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavouriteDoctorViewState();
}

class _FavouriteDoctorViewState extends ConsumerState<FavouriteDoctorView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(favouriteDoctorViewModelProvider.notifier)
          .fetchFavouriteDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favouriteDoctorViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Doctors'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.builder(
                  itemCount: state.favouriteDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = state.favouriteDoctors[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            ApiEndPoints.doctorImageUrl + doctor.id),
                      ),
                      title: Text(doctor.name),
                      subtitle: Text(doctor.field),
                    );
                  },
                ),
    );
  }
}
