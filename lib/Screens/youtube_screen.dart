// ignore_for_file: depend_on_referenced_packages

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
      body: Container(
                  color: Colors.lightBlue[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                    ),
                  ),
                ),
    );
  }
}