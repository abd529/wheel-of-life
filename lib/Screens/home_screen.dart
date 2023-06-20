// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import '/Authentication/login_screen.dart';
import '/Quiz%20Functionality/Quiz/baseline_quiz.dart';
import '../Screens/lanugage_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home-screen";
  const HomeScreen({super.key});

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
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //padding: const EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height / 5,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                  ), //BoxDecoration
                  child: Image.asset(
                    "assets/logo.png",
                    width: size.width / 1.8,
                    height: size.height / 8,
                    fit: BoxFit.contain,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text(' Language'),
                  onTap: () {
                    Navigator.of(context).pushNamed(LanguageScreen.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('LogOut'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    launchUrl(url);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Powered by ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "EzeeLogix",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height / 3,
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
                      IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                            //  print("height: ${MediaQuery.of(context).size.height}");
                            //  print("weight: ${MediaQuery.of(context).size.width}");
                          },
                          icon: const Icon(
                            Icons.menu,
                            size: 35,
                            color: Colors.deepPurple,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: size.width / 1.8,
                        height: size.height / 8,
                        fit: BoxFit.cover,
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
                              "${months[DateTime.now().month]} ${DateTime.now().day}, ${DateTime.now().year}",
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
                            "Welcome to true north",
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
                          "You'll be presented with questions in different areas. You will respond to each one according to the following scale:\n\n1-3: Dissatisfaction \n4-6: Nessacary work needed \n7-8: Good, still room for improvement \n9-10: No Modification is needed \n\nUltimately you'll see your wheel of life and the recommended areas to concentrate on \nYou'll be presented with Baseline questions first. You may respond to that as you may feel today, without much introseption",
                          softWrap: true,
                          style: TextStyle(fontSize: fontSize),
                          textAlign: TextAlign.justify,
                        ),
                      ),
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
                    Navigator.of(context).pushNamed(BaseLineQuiz.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(size.width / 4,
                        size.height / 40, size.width / 4, size.height / 40),
                    shape: RoundedRectangleBorder(
                        //to set border radius to button
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: const Text("Start")),
            )
          ],
        ),
      )),
    );
  }
}
