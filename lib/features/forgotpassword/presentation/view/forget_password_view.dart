// import 'package:flutter/material.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});
//
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   String contactMethod = 'email';
//   String contactValue = '';
//   bool isSentOtp = false;
//   String otp = '';
//   String resetPassword = '';
//   String confirmPassword = '';
//
//   void handleForgotPassword() {
//     // Your logic to send OTP goes here.
//     setState(() {
//       isSentOtp = true;
//     });
//   }
//
//   void handleReset() {
//     // Your logic to reset password goes here.
//   }
//
//   bool validateContact() {
//     if (contactMethod == 'email') {
//       // Add email validation logic
//       return contactValue.contains('@');
//     } else {
//       // Add phone validation logic
//       return contactValue.length == 10;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isSentOtp
//             ? Column(
//                 children: [
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'OTP',
//                       prefixIcon: Icon(Icons.vpn_key),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {
//                       setState(() {
//                         otp = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'New Password',
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                     onChanged: (value) {
//                       setState(() {
//                         resetPassword = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     decoration: const InputDecoration(
//                       labelText: 'Confirm Password',
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                     onChanged: (value) {
//                       setState(() {
//                         confirmPassword = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: handleReset,
//                     child: const Text('Reset Password'),
//                   ),
//                 ],
//               )
//             : Column(
//                 children: [
//                   DropdownButton<String>(
//                     value: contactMethod,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         contactMethod = newValue!;
//                         contactValue = '';
//                       });
//                     },
//                     items: <String>['email', 'phone']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value == 'email' ? 'Email' : 'Phone'),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText:
//                           contactMethod == 'email' ? 'Email' : 'Phone Number',
//                       prefixIcon: Icon(
//                           contactMethod == 'email' ? Icons.email : Icons.phone),
//                     ),
//                     keyboardType: contactMethod == 'email'
//                         ? TextInputType.emailAddress
//                         : TextInputType.phone,
//                     onChanged: (value) {
//                       setState(() {
//                         contactValue = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: validateContact() ? handleForgotPassword : null,
//                     child: const Text('Send OTP'),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }

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
  final TextEditingController _phoneController = TextEditingController();
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
              // Headings
              Text(
                'Forget Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your phone number to reset your password',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),

              // Phone Number Field
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 10),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: forgotPasswordState.isLoading
                      ? null
                      : () {
                          final phone = _phoneController.text.trim();
                          if (phone.isNotEmpty) {
                            forgotPasswordViewModel.sendOtp(phone);
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
                  'Enter the OTP sent to your phone number',
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
                            if (otp.isNotEmpty &&
                                newPassword.isNotEmpty &&
                                newPassword == confirmPassword) {
                              forgotPasswordViewModel.verifyOtp(
                                otp,
                                _phoneController.text.trim(),
                                newPassword,
                              );
                            }
                          },
                    child: forgotPasswordState.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Verify OTP and Change Password'),
                  ),
                ),
              ],

              if (forgotPasswordState.passwordChanged) ...[
                const SizedBox(height: 10),
                const Text(
                  'Your password has been changed successfully!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ],

              if (forgotPasswordState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    forgotPasswordState.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              if (_timer > 0) _buildTimerText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Please wait $_timer seconds before trying again.',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  void _startTimer() {
    setState(() => _timer = 60);
    Future.delayed(const Duration(seconds: 1), () {
      if (_timer > 0) {
        setState(() => _timer--);
        _startTimer();
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
