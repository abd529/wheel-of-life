// ignore_for_file: depend_on_referenced_packages

import 'package:com.ezeelogix.truenorth/Screens/option_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TranslatedVideo extends StatelessWidget {
  static const routeName = "translated-video-screen";
  final String videoId;
  const TranslatedVideo({super.key, required this.videoId});
   

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          Text(AppLocalizations.of(context)!.whatIsTrueNorth, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 50,),
          Container(
                      color: Theme.of(context).primaryColor ,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.intro, textAlign: TextAlign.center,),
                    ),
                    const SizedBox(height: 25,),
                    ElevatedButton(onPressed: (){
                      //
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OptionScreen(),));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/4, size.height/40, size.width/4, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),),
                     child: Text(AppLocalizations.of(context)!.next))
        ],
      ),
    );
  }
}