// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
// import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
//
// class EditProfileView extends ConsumerStatefulWidget {
//   const EditProfileView({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<EditProfileView> createState() => _EditProfileViewState();
// }
//
// class _EditProfileViewState extends ConsumerState<EditProfileView> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _firstNameController;
//   late TextEditingController _lastNameController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   File? _profileImage;
//
//   @override
//   void initState() {
//     super.initState();
//     final user = ref.read(profileViewmodelProvider).authEntity;
//     _firstNameController = TextEditingController(text: user?.fName);
//     _lastNameController = TextEditingController(text: user?.lName);
//     _emailController = TextEditingController(text: user?.email);
//     _phoneController = TextEditingController(text: user?.phone);
//   }
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final profileState = ref.watch(profileViewmodelProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: _profileImage != null
//                       ? FileImage(_profileImage!)
//                       : (profileState.authEntity?.image != null
//                       ? NetworkImage(profileState.authEntity!.image!)
//                       : const AssetImage('assets/images/default_profile.png')) as ImageProvider,
//                   child: _profileImage == null && profileState.authEntity?.image == null
//                       ? const Icon(Icons.camera_alt, size: 50)
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(
//                   labelText: 'First Name',
//                   prefixIcon: Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Last Name',
//                   prefixIcon: Icon(Icons.person_outline),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   // You can add more sophisticated email validation here
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Phone',
//                   prefixIcon: Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   // You can add phone number format validation here
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _updateProfile();
//                   }
//                 },
//                 child: profileState.isLoading
//                     ? const CircularProgressIndicator()
//                     : const Text('Save Changes'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> _updateProfile() async {
//     final viewModel = ref.read(profileViewmodelProvider.notifier);
//
//     if (_profileImage != null) {
//       await viewModel.uploadProfilePicture(_profileImage!);
//     }
//
//     final updatedUser = AuthEntity(
//       userId: ref.read(profileViewmodelProvider).authEntity?.userId,
//       fName: _firstNameController.text,
//       lName: _lastNameController.text,
//       email: _emailController.text,
//       phone: _phoneController.text,
//       password: ref.read(profileViewmodelProvider).authEntity?.password ?? '',
//       image: ref.read(profileViewmodelProvider).authEntity?.image,
//     );
//
//     await viewModel.updateProfile(updatedUser);
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile updated successfully')),
//       );
//       Navigator.of(context).pop();
//     }
//   }
// }
import 'dart:io';

import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/edit_profile/presentation/state/current_state_profile.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController usernameController;

  File? _image;

  @override
  void initState() {
    super.initState();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewmodelProvider);
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Initialize controllers with the current state
    fnameController.text = state.authEntity?.fName ?? '';
    lnameController.text = state.authEntity?.lName ?? '';
    emailController.text = state.authEntity?.email ?? '';
    phoneController.text = state.authEntity?.phone ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Update Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(state),
                const SizedBox(height: 40),
                _buildForm(),
                const SizedBox(height: 20),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(CurrentProfileState state) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 3),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 70,
            backgroundImage: _getProfileImage(state),
          ),
        ),
        FloatingActionButton.small(
          onPressed: () => checkCameraPermission(),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.camera_alt),
        ),
      ],
    );
  }

  ImageProvider _getProfileImage(CurrentProfileState state) {
    if (_image != null) {
      return FileImage(_image!);
    } else if (state.uploadImage.isNotEmpty) {
      return NetworkImage(
          '${ApiEndPoints.imageUrlprofile}${state.uploadImage}');
    } else {
      return const AssetImage('assets/default_profile.png');
    }
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(
            icon: Icons.person,
            hintText: 'First Name',
            controller: fnameController),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.person,
            hintText: 'Last Name',
            controller: lnameController),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.email, hintText: 'E-Mail', controller: emailController),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.phone,
            hintText: 'Phone No',
            controller: phoneController),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color),
        hintText: hintText,
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        ref.read(profileViewmodelProvider.notifier).updateUser(
              AuthEntity(
                userId: ref.read(profileViewmodelProvider).authEntity!.userId,
                fName: fnameController.text,
                lName: lnameController.text,
                email: emailController.text,
                phone: phoneController.text,
                image: ref.watch(profileViewmodelProvider).uploadImage,
              ),
            );
      },
      child: const Text('Save Changes'),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Failed to upload image: $error',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.error),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        'Image uploaded successfully',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      _pickImage();
    } else {
      if (await Permission.camera.request().isGranted) {
        _pickImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Camera permission is required to take pictures')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      ref.read(profileViewmodelProvider.notifier).uploadProfilePicture(_image!);
    }
  }
}
