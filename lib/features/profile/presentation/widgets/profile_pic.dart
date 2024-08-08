import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? imageUrl;

  const ProfilePic({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl != null
                ? NetworkImage(imageUrl!)
                : AssetImage('assets/images/default_profile.png')
                    as ImageProvider,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
            ),
          ),
        ],
      ),
    );
  }
}
