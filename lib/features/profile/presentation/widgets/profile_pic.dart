import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePic extends ConsumerWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewmodelProvider);
    final imageUrl = profileState.uploadImage;

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null
                ? NetworkImage('${ApiEndPoints.imageUrlprofile}$imageUrl')
                : AssetImage('assets/images/default_profile.png')
                    as ImageProvider,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePic(),
                    ),
                  );
                },
                child: const Icon(Icons.remove_red_eye_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
