import 'dart:convert';

import 'package:com.ezeelogix.truenorth/Screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class VerifyEmail extends StatefulWidget {
  static const routeName = "verify-name";
  final String fileUrl;
  final String imgUrl;
  final String uid;
  final String coachLang;
  final String coachBadge;
  final String coachGen;
  final bool isCoach; 
  const VerifyEmail({super.key, required this.fileUrl, required this.imgUrl, required this.uid, required this.coachLang, required this.coachBadge, required this.coachGen, required this.isCoach});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmEmail = TextEditingController();
  TextEditingController code = TextEditingController();
  bool sent = false;
  String shortenedUrl = "";

  @override
  void initState() {
    super.initState();
  }

  Future<String> shortenUrl(String longUrl) async {
  final response = await http.post(
    Uri.parse('https://api-ssl.bitly.com/v4/shorten'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 885789a550e82e100742f485c36ea732366bac76',
    },
    body: '{"long_url": "$longUrl"}',
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    print(data);
    return data['id'];
  } else {
    throw Exception('Failed to shorten URL');
  }
}

  
  void sendEmail(
    String recipientEmail, String messageMail, BuildContext context) async {
    setState(() {
      sent = true;
    });
    String userName2 = "gesconvsgar@ezeelogix.com";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "gesconvsgar@ezeelogix.com",
        password: "ges23@conv",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = "Next Steps on Your True North Journey"
      ..text = messageMail
      ..html = widget.isCoach? """
<p> Dear ${name.text},<br><br>
    Congratulations on taking the first step towards uncovering your True North! Your commitment to 
    self-discovery is truly commendable. To further assist and guide you on this transformative journey, 
    we recommend connecting with a professional coach. If you've chosen this path, rest assured that a skilled 
    coach will be in touch with you shortly to provide valuable insights and support.<br><br>
    A/An ${widget.coachLang} speaking ${widget.coachGen} coach with a ${widget.coachBadge} badge will approch you soon<br><br>
    Thank you for placing your trust in us. We're here to help you every step of the way. Should you have 
    any questions or inquiries, please don't hesitate to reach out.<br>
    <a href="${widget.fileUrl}">You can find your report here</a></p>

    Wishing you all the best as you continue your quest to find your True North.<br>
    Warm regards,<br>
    The True North Team<br>
    www.DrJDKropman.com  """ : """
<p> Dear ${name.text},<br><br>
    Congratulations on taking the first step towards uncovering your True North! Your commitment to 
    self-discovery is truly commendable. To further assist and guide you on this transformative journey, 
    we recommend connecting with a professional coach. If you've chosen this path, rest assured that a skilled 
    coach will be in touch with you shortly to provide valuable insights and support.<br><br>
    Thank you for placing your trust in us. We're here to help you every step of the way. Should you have 
    any questions or inquiries, please don't hesitate to reach out.<br>
    <a href="${widget.fileUrl}">You can find your report here</a></p>

    Wishing you all the best as you continue your quest to find your True North.<br>
    Warm regards,<br>
    The True North Team<br>
    www.DrJDKropman.com  """;
    try {
      await send(message, smtpServer2);
      dailogeBox();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void dailogeBox(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Email Sent Successfully', style: TextStyle(fontSize: 18),),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                 Text('Taking you back to home'),
                 SizedBox(height: 30,),
                 CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
     Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(uid: widget.uid) ,), (route) => false);
    });
    setState(() {
      sent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Image.asset(
              "assets/logo.png",
              width: size.width / 4,
              height: size.height / 8,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: 
                      Text(
                        AppLocalizations.of(context)!.verifyEmail,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Verify your email to recieve report")),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: 
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              width: 1.0, color: Colors.black),
                                        ),
                                      ),
                                      child: const Icon(Icons.person)),
                                ),
                                hintText: " ${AppLocalizations.of(context)!.fullName}"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              width: 1.0, color: Colors.black),
                                        ),
                                      ),
                                      child: const Icon(Icons.phone_android)),
                                ),
                                hintText: " ${AppLocalizations.of(context)!.number}"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              width: 1.0, color: Colors.black),
                                        ),
                                      ),
                                      child: const Icon(Icons.mail)),
                                ),
                                hintText: " Your ${AppLocalizations.of(context)!.email}"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(widget.isCoach){
                            sendEmail(email.text,
                           """
                           Dear ${name.text},\n
                           Congratulations on taking the first step towards uncovering your True North! Your commitment to 
                           self-discovery is truly commendable. To further assist and guide you on this transformative journey, 
                           we recommend connecting with a professional coach. If you've chosen this path, rest assured that a skilled 
                           coach will be in touch with you shortly to provide valuable insights and support.\n
                           A/An ${widget.coachLang} speaking ${widget.coachGen} coach with a ${widget.coachBadge} badge will approch you soon\n
                           Thank you for placing your trust in us. We're here to help you every step of the way. Should you have 
                           any questions or inquiries, please don't hesitate to reach out.\n
                           You can find your report here: \n

                           Wishing you all the best as you continue your quest to find your True North.
                           Warm regards,
                           The True North Team
                           www.DrJDKropman.com 
                           """,
                            context);
                          }else{
                            sendEmail(email.text,
                           """
                           Dear ${name.text},\n
                           Congratulations on taking the first step towards uncovering your True North! Your commitment to 
                           self-discovery is truly commendable. To further assist and guide you on this transformative journey, 
                           we recommend connecting with a professional coach. If you've chosen this path, rest assured that a skilled 
                           coach will be in touch with you shortly to provide valuable insights and support.\n
                           Thank you for placing your trust in us. We're here to help you every step of the way. Should you have 
                           any questions or inquiries, please don't hesitate to reach out.\n
                           You can find your report here: ${widget.fileUrl}\n
                           Wishing you all the best as you continue your quest to find your True North.
                           Warm regards,
                           The True North Team
                           www.DrJDKropman.com 
                           """,
                            context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      child:  sent? const CircularProgressIndicator(color: Colors.purple,) : const Text("Send Me Report")),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "You'll be contacted by a professional coach to give you result of the Wheel of Life without any obligation.",
                    textAlign: TextAlign.center,
                  ),
                  // ElevatedButton(onPressed: (){
                  //   print("hehe");
                  //   shortenUrl(widget.fileUrl);
                  // }, child: const Text("testtt box"))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
