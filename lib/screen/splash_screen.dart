// import 'dart:async';

// import 'package:final_assignment/screen/login.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> _animation;
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );
//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_controller);
//     _controller.forward().then((_) {
//       // After animation completes, navigate to the Login screen
//       Timer(const Duration(seconds: 4), () {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const Login(),
//           ),
//         );
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(),
//           Center(
//             child: FadeTransition(
//               opacity: _animation,
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 width: 100,
//                 height: 180,
//               ),
//             ),
//           ),
//           const Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//                 child: CircularProgressIndicator(),
//               ),
//               Center(
//                 child: Text(
//                   'version 1.0.0',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12.0,
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
