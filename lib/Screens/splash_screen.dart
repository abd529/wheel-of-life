import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'onboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        nextScreen: const Onboard(),
        splash: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wheel of life", style: TextStyle(fontSize: 36)),
          ],
        ),
      ),
    );
  }
}