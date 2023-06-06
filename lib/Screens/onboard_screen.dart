import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.example.wheel_of_life/Screens/youtube_screen.dart';
import 'package:com.example.wheel_of_life/Utilities/youtube_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../payment.dart';
import '/Authentication/login_screen.dart';
import '/Quiz%20Functionality/Quiz/family_quiz.dart';
import '/Quiz%20Functionality/Quiz/love_quiz.dart';
import '/Screens/email.dart';
import '/Screens/home_screen.dart';
import '/Screens/report.dart';
import '/Screens/stripe_payment.dart';

import '../Quiz Functionality/Quiz/baseline_quiz.dart';
import '../Quiz Functionality/Quiz/free_quiz.dart';
import '../Quiz Functionality/Quiz/health_quiz.dart';
import '../Quiz Functionality/Quiz/home_quiz.dart';
import '../Quiz Functionality/Quiz/money_quiz.dart';
import '../Quiz Functionality/Quiz/p_growth_quiz.dart';
import '../Quiz Functionality/Quiz/work_quiz.dart';
import '../main.dart';

class Onboard extends StatefulWidget {
  static const routeName = "onboard";
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  String videoId = "R0T-CDZbWUQ";
  String videoFren = "eM87_FC3OvA";
  String videoSpa = "p520iOvkMd4";
  // https://youtu.be/pPr90LMH3kY
  String videoITA = "pPr90LMH3kY";
  String videoPor = "Ijy2nR6Cl3I";
  String videoEng = "R0T-CDZbWUQ";
  String videoChi = "Ga7S_dnG5rQ";
  String email = "";
  String fName = "";
  String lName = "";
  int num = 0;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  getInfo() async {
    var collection = FirebaseFirestore.instance.collection('UsersData');
    var docSnapshot = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        email = data?["Email"];
        fName = data?["First Name"];
        lName = data?["Last Name"];
      });
    }
  }

  changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
    if (value == "es") {
      setState(() {
        videoId = videoSpa;
      });
    }
    if (value == "pt") {
      setState(() {
        videoId = videoPor;
      });
    }
    if (value == "fr") {
      setState(() {
        videoId = videoFren;
      });
    }
    if (value == "en") {
      setState(() {
        videoId = videoEng;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (num == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      num++;
    }
    String lang = Localizations.localeOf(context).toString();
    print(lang);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  children: [
                    const Text("Espanol"),
                    Radio(
                        value: "es", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                Row(
                  children: [
                    const Text("Portuguese"),
                    Radio(
                        value: "pt", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                Row(
                  children: [
                    const Text("Francias"),
                    Radio(
                        value: "fr", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                Row(
                  children: [
                    const Text("English"),
                    Radio(
                        value: "en", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                Row(
                  children: [
                    const Text("Italiano"),
                    Radio(
                        value: "it", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                Row(
                  children: [
                    const Text("中文的"),
                    Radio(
                        value: "zh", groupValue: lang, onChanged: changeLocale),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TranslatedVideo(
                                videoId: videoId,
                              )));
                    },
                    child: const Text("Next")),
                // Text("The current language is ${AppLocalizations.of(context)!.language}", style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                // const SizedBox(height: 80,),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(DetailPage.routeName);
                // }, child: const Text("Report Screen")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(BaseLineQuiz.routeName);
                // }, child: const Text("Base Line Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(HealthQuiz.routeName);
                // }, child: const Text("Health Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(PersonalQuiz.routeName);
                // }, child: const Text("Personal Growth Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(HomeQuiz.routeName);
                // }, child: const Text("Home Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(FamilyQuiz.routeName);
                // }, child: const Text("Family & Friends Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(LoveQuiz.routeName);
                // }, child: const Text("Love Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(FreeQuiz.routeName);
                // }, child: const Text("Free Time Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(WorkQuiz.routeName);
                // }, child: const Text("Work Quiz")),
                // ElevatedButton(onPressed: (){
                //   Navigator.of(context).pushNamed(MoneyQuiz.routeName);
                // }, child: const Text("Money Quiz")),
                // ElevatedButton(onPressed: ()async{
                //    await FirebaseAuth.instance.signOut();
                //    Navigator.of(context).pushNamed(EmailSend.routeName);
                // }, child: const Text("Email Send")),
                // ElevatedButton(onPressed: ()async{
                //    Navigator.of(context).pushNamed(HomeScreen.routeName);
                // }, child: const Text("Home")),
                // ElevatedButton(onPressed: ()async{
                //    Navigator.of(context).pushNamed(StripePayment.routeName);
                // }, child: const Text("Stripe")),
                // ElevatedButton(onPressed: ()async{
                //    Navigator.of(context).pushNamed(StripePayment3.routeName);
                // }, child: const Text("Pay")),
                // ElevatedButton(onPressed: ()async{
                //    await FirebaseAuth.instance.signOut();
                //    Navigator.of(context).pushNamed(LoginScreen.routeName);
                // }, child: const Text("Log out")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
