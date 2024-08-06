import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String contactMethod = 'email';
  String contactValue = '';
  bool isSentOtp = false;
  String otp = '';
  String resetPassword = '';
  String confirmPassword = '';

  void handleForgotPassword() {
    // Your logic to send OTP goes here.
    setState(() {
      isSentOtp = true;
    });
  }

  void handleReset() {
    // Your logic to reset password goes here.
  }

  bool validateContact() {
    if (contactMethod == 'email') {
      // Add email validation logic
      return contactValue.contains('@');
    } else {
      // Add phone validation logic
      return contactValue.length == 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSentOtp
            ? Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        resetPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleReset,
                    child: const Text('Reset Password'),
                  ),
                ],
              )
            : Column(
                children: [
                  DropdownButton<String>(
                    value: contactMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        contactMethod = newValue!;
                        contactValue = '';
                      });
                    },
                    items: <String>['email', 'phone']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == 'email' ? 'Email' : 'Phone'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText:
                          contactMethod == 'email' ? 'Email' : 'Phone Number',
                      prefixIcon: Icon(
                          contactMethod == 'email' ? Icons.email : Icons.phone),
                    ),
                    keyboardType: contactMethod == 'email'
                        ? TextInputType.emailAddress
                        : TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        contactValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: validateContact() ? handleForgotPassword : null,
                    child: const Text('Send OTP'),
                  ),
                ],
              ),
      ),
    );
  }
}
