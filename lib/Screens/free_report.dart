import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class FreeReport extends StatefulWidget {
  static const routeName = "free-report";
  const FreeReport({super.key});

  @override
  State<FreeReport> createState() => _FreeReportState();
}

class _FreeReportState extends State<FreeReport> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController confirmEmail = TextEditingController();
  TextEditingController code = TextEditingController();
  void sendEmail(
      String recipientEmail, String messageMail, BuildContext context) async {
    String userName2 = "gesconvsgar@ezeelogix.com";
    String password2 = "ges23@conv";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "gesconvsgar@ezeelogix.com",
        password: "ges23@conv",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "Mail Service")
      ..recipients.add(recipientEmail)
      ..subject = "Mail"
      ..text = "Message: $messageMail";
    try {
      await send(message, smtpServer2);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: FittedBox(
        child: Text("Email send good"),
      )));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: SafeArea(child: 
        SizedBox(width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/logo.png",
              fit: BoxFit.cover,
              width: size.width/2,height: size.height/8,)),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:   [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Free Report", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("A free report will be sent to you and your professional coach")),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: name,
                              validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                              decoration:  InputDecoration(
                                prefixIcon: Container(
                                   decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                                  child: const Icon(Icons.person)),
                                hintText: " Your Name"
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: phone,
                              validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                   decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                                  child: const Icon(Icons.phone_android)),
                                hintText: " Phone Number"
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: email,
                              validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                   decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                                  child: const Icon(Icons.mail)),
                                hintText: " Your Email"
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: confirmEmail,
                              validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your email';
                        }
                        return null;
                      },
                              decoration:  InputDecoration(
                                prefixIcon: Container(
                                   decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                                  child: const Icon(Icons.mail)),
                                hintText: " Confirm Email"
                              ),
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: code,
                              validator:(value) {
                        if (value!.isEmpty) {
                          return 'Please enter a code';
                        }
                        return null;
                      },
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                   decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                                  child: const Icon(Icons.lock_outline_rounded)),
                                hintText: " Code"
                              ),
                            ),
                          ],
                        )
                        ),
                        const SizedBox(height: 30,),
                        const Text("Don't have a free code?"),
                        ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                           child: const Text("Contact Me") ),
                        
                        const SizedBox(height: 30,),
                        const Text("The Code will be given by the coach to its clients, and it will allow users to get the result for free and also will send the result to the email associated with the coach.",
                        textAlign: TextAlign.center,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              sendEmail(email.text, "heyyyyy", context);
                            }
                          }, 
                          style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                          child: Text("Get your free results") ),
                  ],
                ),
              ),
              
          ],
        ),
        )
        ),
      ),
    );
  }
}