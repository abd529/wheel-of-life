import 'package:com.ezeelogix.truenorth/Authentication/login_screen.dart';
import 'package:com.ezeelogix.truenorth/Screens/coach_panel.dart';
import 'package:com.ezeelogix.truenorth/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      SafeArea(child: 
      SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Image.asset(
                             "assets/logo.png",
                              width: size.width/1.6,
                              height: size.height/5,
                              fit: BoxFit.contain,
                            ),
            Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(size.width/5, size.height/40, size.width/5, size.height/40),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                  child: Text(AppLocalizations.of(context)!.home),onPressed: (){
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },),
                const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                            ),),
              child: Text(AppLocalizations.of(context)!.coachPanel),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CoachPanel(),));
            },),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                            ),),
              child: Text(AppLocalizations.of(context)!.adminPanel),onPressed: (){
              Navigator.of(context).pushNamed(LoginScreen.routeName);
            },)
              ],
            ),
            const SizedBox(height: 100,)
          ]
        ),
      )),
    );
  }
}