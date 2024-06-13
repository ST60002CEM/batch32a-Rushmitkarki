import 'package:final_assignment/features/splash/presentation/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    ref.read(splashViewModelProvider.notifier).openLoginView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Center(
            child: SizedBox(
              width: 100, // Set your desired width
              height: 100, // Set your desired height
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: CircularProgressIndicator(),
              ),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
