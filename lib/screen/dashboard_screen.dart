import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 12, 41, 91),
        ),
        body: Column(
          children: <Widget>[
            Center(
              // Wrap the Image.asset with Center
              child: Image.asset(
                'assets/images/logo.png',
                width: 100.0,
                height: 100.0,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(' This is Dashboard Screen'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
