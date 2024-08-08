import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart';
import 'package:final_assignment/features/favouritedoctors/presentation/viewmodel/favourite_doctors_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavouriteDoctorView extends ConsumerStatefulWidget {
  const FavouriteDoctorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouriteDoctorViewState();
}

class _FavouriteDoctorViewState extends ConsumerState<FavouriteDoctorView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favouriteDoctorViewModelProvider.notifier).fetchFavouriteDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favouriteDoctorViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Doctors'),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(favouriteDoctorViewModelProvider.notifier).fetchFavouriteDoctors();
        },
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody( state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${state.error}', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(favouriteDoctorViewModelProvider.notifier).fetchFavouriteDoctors();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state.favouriteDoctors.isEmpty) {
      return const Center(
        child: Text(
          'No favourite doctors',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: state.favouriteDoctors.length,
        itemBuilder: (context, index) {
          final doctor = state.favouriteDoctors[index];
          return _buildDoctorCard(doctor);
        },
      );
    }
  }

  Widget _buildDoctorCard(FavouriteEntity doctor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Slidable(
        key: Key(doctor.doctor.doctorid!),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            ref.read(favouriteDoctorViewModelProvider.notifier).removeFavouriteDoctor(doctor.id);
            showMySnackBar(message: 'Doctor removed from favourites', color: Colors.red);
          }),
          children: [
            SlidableAction(
              onPressed: (context) {
                ref.read(favouriteDoctorViewModelProvider.notifier).removeFavouriteDoctor(doctor.id);
            showMySnackBar(message: 'Doctor removed from favourites', color: Colors.red);

              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remove',
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(ApiEndPoints.doctorImageUrl + doctor.doctor.doctorImage),
            ),
            title: Text(
              doctor.doctor.doctorName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  doctor.doctor.doctorField,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  'Experience: ${doctor.doctor.doctorExperience} years',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to doctor details page
            },
          ),
        ),
      ),
    );
  }
}