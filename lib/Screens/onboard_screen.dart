
// ignore_for_file: avoid_print

import 'package:com.ezeelogix.truenorth/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Onboard extends StatefulWidget {
  static const routeName = "onboard";
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  String videoId = "1uhrwiKn0sw";
  String videoFren = "XxHBSviCLP0";
  String videoSpa = "yP4TfpkmmxA";
  String videoITA = "DUFWqmJm7Es";
  String videoPor = "TgPzMw09w2w";
  String videoEng = "1uhrwiKn0sw";
  String videoChi = "Zh9fDF5zqOQ";
  String videoGer = "M-FoePRGd_U";
  String email = "";
  String fName = "";
  String lName = "";
  int num = 0;


  // getInfo() async {
  //   var collection = FirebaseFirestore.instance.collection('UsersData');
  //   var docSnapshot = await collection.doc(userId).get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     setState(() {
  //       email = data?["Email"];
  //       fName = data?["First Name"];
  //       lName = data?["Last Name"];
  //     });
  //   }
  // }

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
    if (value == "it") {
      setState(() {
        videoId = videoITA;
      });
    }
    if (value == "zh") {
      setState(() {
        videoId = videoChi;
      });
    }
    if (value == "de") {
      setState(() {
        videoId = videoGer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    // if (num == 0) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
    //   num++;
    // }
    Size size = MediaQuery.of(context).size;
    String lang = Localizations.localeOf(context).toString();
    print(lang);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height/15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Choose Your Language", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Español", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "es", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Portuguese", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "pt", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Francias", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "fr", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("English", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "en", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Italiano", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "it", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("中文的", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "zh", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("German", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "de", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Welcome(videoId: videoId),
                      ));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => TranslatedVideo(
                    //           videoId: videoId,
                    //         )));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/4, size.height/40, size.width/4, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),
                    ),
                  child: const Text("Next")),
                  const SizedBox(height:20),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                  //       shape: RoundedRectangleBorder( //to set border radius to button
                  // borderRadius: BorderRadius.circular(50)
                  //           ),
                  //   ),
                  //   onPressed: (){
                      
                  //   }, child: const Text("Coach Panel") ),
                  // TextButton(onPressed: (){
                    
                  // }, child: const Text("Go to Admin Panel"))
                  
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
    );
  }
}
