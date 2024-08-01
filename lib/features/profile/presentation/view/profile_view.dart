import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_menu.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(profileViewmodelProvider.notifier).initialize(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: profileState.authEntity?.fName ?? "First Name",
              icon: "assets/icons/user.svg",
              press: () {
                if (mounted) {
                  ref
                      .read(profileViewmodelProvider.notifier)
                      .openEditProfileView();
                }
              },
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/bell.svg",
              press: () {
                // Navigate to Notifications screen
              },
            ),
            ProfileMenu(
              text: "Favorite Doctors",
              icon: "assets/icons/doctor.svg",
              press: () {
                // Navigate to Favorite Doctors screen
              },
            ),
            ProfileMenu(
              text: "My Appointment List",
              icon: "assets/icons/appointment.svg",
              press: () {
                // Navigate to My Appointment List screen
              },
            ),
            ProfileMenu(
              text: "Enable Finger Print",
              icon: "assets/icons/fingerprint.svg",
              press: () {
                if (mounted) {
                  ref
                      .read(profileViewmodelProvider.notifier)
                      .enableFingerprint();
                }
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/logout.svg",
              press: () {
                if (mounted) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    title: 'Logout',
                    desc: 'Are You Sure You Want To Logout?',
                    btnOkOnPress: () {
                      if (mounted) {
                        ref.read(profileViewmodelProvider.notifier).logout();
                      }
                    },
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
