// ignore_for_file: unused_local_variable

import 'package:com.ezeelogix.truenorth/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return EasySplashScreen(
      logo: Image.asset(
              "assets/logo.png",
              width: size.width/1.6,
              height: size.height/5,
              fit: BoxFit.cover,
            ),
      title: const Text(
        "True North",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      showLoader: true,
      loaderColor: Colors.deepPurple,
      loadingText: const Text("Loading"),
      navigator: const Welcome(),
      durationInSeconds: 5,
    );
    // return Scaffold(
    //   body: AnimatedSplashScreen(
    //     nextScreen: const Onboard(),
    //     duration: 9000,
    //     splash: 
    //     Image.asset("assets/logo.png", fit: BoxFit.contain)
    //     //"assets/logo.png" 
    //     // const Column(
    //     //   children: [
    //     //     ImageIcon(AssetImage("assets/logo.png"))
    //     //   ],
    //     // )
    //   ),
    // );
  }
}