// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '/Quiz%20Functionality/Quiz/baseline_quiz.dart';
import '../Screens/lanugage_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Uri url = Uri.parse('https://ezeelogix.com/');

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontSize;
    double title;
    // if (screenHeight < 320) {
    //   fontSize = 13.0;
    //   title = 20;
    //   heading = 20; // Small screen (e.g., iPhone 4S)
    // } else if (screenWidth < 375) {
    //   fontSize = 17.0;
    //   title = 28;

    //   heading = 21; // Medium screen (e.g., iPhone 6, 7, 8)
    // } else if (screenWidth < 414) {
    //   fontSize = 14.0;
    //   title = 32;

    //   heading = 25; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    // } else if (screenWidth < 600) {
    //   fontSize = 14.0;
    //   title = 36;

    //   heading = 27; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    // } else {
    //   fontSize = 25.0;
    //   title = 40;

    //   heading = 30; // Extra large screen or unknown device
    // }
    if (screenHeight < 560) {
      fontSize = 11.0;
      title = 14.0;
    } else if (screenHeight <= 650) {
      fontSize = 12.0;
      title = 18.0;
    } else if (screenHeight <= 725) {
      fontSize = 13.0;
      title = 20.0;
    } else if (screenHeight <= 790) {
      fontSize = 14.0;
      title = 22.0;
    } else {
      fontSize = 15;
      title = 24.0;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
     // appBar: AppBar(leading: const SizedBox(), backgroundColor: Colors.deepPurple.withOpacity(0.1),),
      key: _scaffoldKey,
       drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //padding: const EdgeInsets.all(0),
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height/5,
                    decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ), //BoxDecoration
                child: Image.asset(
                           "assets/logo.png",
                            width: size.width/1.8,
                            height: size.height/8,
                           // fit: BoxFit.contain,
                          ),
                  ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                onTap: () {
                  Navigator.of(context).pushNamed(LanguageScreen.routeName);
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.logout),
              //   title: const Text("logout"),
              //   onTap: () {
              //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen()), (route) => false);
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(Icons.logout),
              //   title: const Text('LogOut'),
              //   onTap: () async {
              //     await FirebaseAuth.instance.signOut();
              //     Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => LoginScreen(),
              //         ),
              //         (Route<dynamic> route) => false);
              //   },
              // ),
                ],
              ),
              
            Column(children: [
              TextButton(onPressed: (){
                launchUrl(url);
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Powered by ", style: TextStyle(color: Colors.grey),),
                    Text("EzeeLogix", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),)
            ],)          
            ],
          ),
        ),

      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: size.height / 2.5,
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SafeArea(
                    child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                          //  print("height: ${MediaQuery.of(context).size.height}");
                          //  print("weight: ${MediaQuery.of(context).size.width}");
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 35,
                          color: Colors.deepPurple,
                        )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                     "assets/logo-bg.png",
                      width: size.width/1.8,
                      height: size.height/8,
                      //fit: BoxFit.cover,
                    ),
                ],
              ),
              //SizedBox(height: size.height/10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${months[DateTime.now().month-1]} ${DateTime.now().day}, ${DateTime.now().year}",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: title - 9),
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "True North",
                          style: TextStyle(
                              fontSize: title,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.welcome ,
                        style: TextStyle(fontSize: title - 9),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // const Text("True North", style: TextStyle(fontSize: 20),),
                  //SizedBox(height: size.height/60,),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      AppLocalizations.of(context)!.homeDescription,
                      softWrap: true,
                      style: TextStyle(fontSize: fontSize),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // ElevatedButton(onPressed: (){
                  
                  //   print(widget.uid);
                  // }, child: const Text("uid"))
                  //SizedBox(height: size.height/30,),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BaseLineQuiz(userId: widget.uid),));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(size.width / 4,
                    size.height / 40, size.width / 4, size.height / 40),
                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: Text(AppLocalizations.of(context)!.start)),
        ),
        const SizedBox(height: 80,)
      ],
        ),
      ),
    );
  }
}
