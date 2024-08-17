import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 12, 41, 91),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo.png',
                width: 100.0,
                height: 100.0,
              ),
              const SizedBox(height: 30),
              _buildTextField(firstNameController, "First Name", Icons.person),
              const SizedBox(height: 20.0),
              _buildTextField(lastNameController, "Last Name", Icons.person),
              const SizedBox(height: 20.0),
              _buildTextField(emailController, "Email", Icons.email),
              const SizedBox(height: 20.0),
              _buildTextField(
                  phoneNumberController, "Phone Number", Icons.phone),
              const SizedBox(height: 20.0),
              _buildTextField(passwordController, "Password", Icons.lock,
                  isPassword: true),
              const SizedBox(height: 20.0),
              _buildTextField(
                  confirmPasswordController, "Confirm Password", Icons.lock,
                  isPassword: true),
              const SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleRegistration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 12, 41, 91),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: hint,
        prefixIcon: Icon(icon),
        fillColor: Colors.white70,
      ),
    );
  }

  void _handleRegistration() {
    AuthEntity authEntity = AuthEntity(
      fName: firstNameController.text,
      lName: lastNameController.text,
      email: emailController.text,
      phone: phoneNumberController.text,
      password: passwordController.text,
    );

    ref.read(authViewModelProvider.notifier).registerUser(authEntity);
  }
}
