import 'dart:async';

import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/forgotpassword/presentation/viewmodel/forget_password_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends ConsumerState<ForgetPasswordView> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  int _timer = 0;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordViewModelProvider);
    final forgotPasswordViewModel =
        ref.read(forgotPasswordViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(loginNavigatorProvider).openLoginView();
            },
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'Select a method to reset your password',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Phone'),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: forgotPasswordState.isPhoneSelected,
                        onChanged: (bool? value) {
                          forgotPasswordViewModel.state =
                              forgotPasswordViewModel.state
                                  .copyWith(isPhoneSelected: value ?? true);
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Email'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: forgotPasswordState.isPhoneSelected,
                        onChanged: (bool? value) {
                          forgotPasswordViewModel.state =
                              forgotPasswordViewModel.state
                                  .copyWith(isPhoneSelected: value ?? false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: forgotPasswordState.isPhoneSelected
                      ? 'Phone Number'
                      : 'Email Address',
                  prefixIcon: Icon(
                    forgotPasswordState.isPhoneSelected
                        ? Icons.phone
                        : Icons.email,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: forgotPasswordState.isLoading
                      ? null
                      : () {
                          final contact = _contactController.text.trim();
                          if (contact.isNotEmpty) {
                            forgotPasswordViewModel.sendOtp(
                              contact: contact,
                              isPhone: forgotPasswordState.isPhoneSelected,
                            );
                            _startTimer();
                          }
                        },
                  child: forgotPasswordState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ),
              if (forgotPasswordState.isSent) ...[
                const SizedBox(height: 10),
                Text(
                  'Enter the OTP sent to your ${forgotPasswordState.isPhoneSelected ? "phone number" : "email"}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: Icon(Icons.security),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter your new password',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: forgotPasswordState.isLoading
                        ? null
                        : () {
                            final otp = _otpController.text.trim();
                            final newPassword = _passwordController.text.trim();
                            final confirmPassword =
                                _confirmPasswordController.text.trim();
                            if (newPassword == confirmPassword &&
                                otp.isNotEmpty) {
                              forgotPasswordViewModel.verifyOtp(
                                contact: _contactController.text.trim(),
                                otp: otp,
                                password: newPassword,
                                isPhone: forgotPasswordState.isPhoneSelected,
                              );
                            }
                          },
                    child: forgotPasswordState.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Reset Password'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      _timer = 60;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          timer.cancel();
        }
      });
    });
  }
}
