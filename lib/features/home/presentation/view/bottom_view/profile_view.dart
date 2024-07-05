import 'package:final_assignment/features/home/presentation/viewmodel/profile_view_model.dart';
import 'package:final_assignment/features/home/presentation/widgets/profile_menu.dart';
import 'package:final_assignment/features/home/presentation/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_menu.dart';
import 'package:final_assignment/features/profile/presentation/widgets/profile_pic.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void dispose() {
    // Dispose the profile state
    ref.invalidate(profileViewmodelProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewmodelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: profileState.authEntity?.fullName ?? "Email",
              icon: "assets/icons/profile.svg",
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
              icon: "assets/icons/Bell.svg",
              press: () {
                // Navigate to Notifications screen
              },
            ),
            ProfileMenu(
              text: "Change Password",
              icon: "assets/icons/password.svg",
              press: () {
                // Navigate to Settings screen
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
          ],
        ),
      ),
    );
  }
}
