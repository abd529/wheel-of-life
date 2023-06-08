// ignore_for_file: depend_on_referenced_packages

import 'package:com.example.wheel_of_life/Authentication/signup_screen.dart';
import 'package:com.example.wheel_of_life/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TranslatedVideo extends StatelessWidget {
  static const routeName = "translated-video-screen";
  final String videoId;
  const TranslatedVideo({super.key, required this.videoId});
   

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("What is True North?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 50,),
          Container(
                      color: Colors.lightBlue[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                          shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(50)
                              ),
                      ),
                     child: const Text("Next"))
        ],
      ),
    );
  }
}