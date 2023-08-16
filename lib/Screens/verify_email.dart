import 'package:com.ezeelogix.truenorth/Screens/home_screen.dart';
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
  const VerifyEmail({super.key, required this.fileUrl, required this.imgUrl, required this.uid});

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
      ..subject = "Your wheel of life is here"
      ..text = "Message: $messageMail";
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
          title: Text('Email Sent Successfully'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                 Text('Taking you back to home'),
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
                      child: Text(
                        AppLocalizations.of(context)!.verifyEmail,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Verify your email ")),
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
                                prefixIcon: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: const Icon(Icons.person)),
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
                                prefixIcon: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: const Icon(Icons.phone_android)),
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
                                prefixIcon: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: const Icon(Icons.mail)),
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
                          sendEmail(email.text, "This is your detailed report ${widget.fileUrl} and this is your wheel of life ${widget.imgUrl}", context);
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
                    "I'll be contacted by a professional coach to give me my result of the Wheel of Life without any opbligation.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
