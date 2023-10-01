// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.ezeelogix.truenorth/Screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class FreeReport extends StatefulWidget {
  static const routeName = "free-report";
  final String fileUrl;
  final String imgUrl;
  final String uid;
  const FreeReport({super.key, required this.fileUrl, required this.imgUrl, required this.uid});

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
  TextEditingController codeConfirm = TextEditingController();
  String coachName = "";
  String coachEmail = "";
  bool isLoading = false;
  bool limitOk = false;


// Future<void> markCodeAsFalse(String enteredCode) async {
//   setState(() {
//     isLoading = true;
//   });
//   final firestoreInstance = FirebaseFirestore.instance;

//   // Reference to the "coaches" collection
//   CollectionReference coachesCollection = firestoreInstance.collection("coaches");

//   try {
//     // Query the "coaches" collection to find the document(s) containing the entered code
//     QuerySnapshot querySnapshot = await coachesCollection.where("codes.$enteredCode", isEqualTo: true).get();

//     // Check if any documents match the entered code
//     if (querySnapshot.docs.isNotEmpty) {
//       // Loop through matching documents and update the code value to false
//       for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
//         Map<String, dynamic>? codes = (docSnapshot.data() as Map<String, dynamic>?)?["codes"];
//         codes![enteredCode] = false;

//         // Fetch the coach's name
//         coachName = (docSnapshot.data() as Map<String, dynamic>?)!["name"];
//         coachEmail = (docSnapshot.data() as Map<String, dynamic>?)!["email"];
//          print(coachEmail);

//         await docSnapshot.reference.update({"codes": codes});
        
//         print("Code '$enteredCode' updated to false for Coach '$coachName' successfully.");
//       }
//     } else {
//       // No matching code found
//       print("Code '$enteredCode' not found.");
//       setState(() {
//     isLoading = false;
//   });
//     }
//   } catch (e) {
//     print("Error updating code: $e");
//     setState(() {
//     isLoading = false;
//   });
//   }
//}


  
  Future<void> sendEmail(
      String recipientEmail, String messageMail, bool isCoach ,BuildContext context) async {
    String userName2 = "Team@MyTrueNorthPath.com";
    //String password2 = "P@ki15t@n!";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add( isCoach? code.text !="ab000"?  recipientEmail : "reports@drjdkropman.com" : recipientEmail)
      ..subject = "Report"
      ..text = messageMail
      ..html = isCoach? """
    <p> Dear $coachName,<br><br>
    We trust this email finds you well. We wanted to inform you that our client, 
    ${name.text}, has recently completed the Wheel of Life questionnaire, and you can access 
    the report using the following link: <a href="${widget.fileUrl}">Report</a><br><br>
    We have also sent an email to ${name.text}, letting them know that you will be reaching
    out to them at your earliest convenience. They have been advised to contact you directly 
    should they have any questions or require further assistance.<br></p>

    Thank you for choosing True North. We look forward to the opportunity to continue serving 
    you and your clients in the future.<br>
    Sincerely,<br>
    The True North Team<br>
    www.mytruenorthpath.com """: """
<p> Dear ${name.text},<br><br>
    We sincerely appreciate your trust in True North to guide you in discovering your deep desires.<br><br>
    As per your Access Code, we've forwarded your report to your dedicated coach ${code.text!="ab000"? coachName:""}. 
    Expect to hear from them shortly. If you have any questions or need immediate assistance, 
    please feel free to reach out to your coach directly.<br><br>

    Thank you once again for choosing True North. We're here to support you on your journey.<br>
    Warm regards,<br>
    The True North Team<br>
    www.mytruenorthpath.com """;
    try {
      await send(message, smtpServer2);
      setState(() {
    isLoading = false;
    print("email is sent to $recipientEmail");
  });
    dailogeBox();
  
    } catch (e) {
      if (kDebugMode) {
        print("email error: $e");
      }
  //     setState(() {
  //   isLoading = false;
  // });
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
  }

Future<void> useCoachCode(String code) async {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference coachesCollection = firestoreInstance.collection("coaches");

  // Query the "coaches" collection to find the code
  final QuerySnapshot querySnapshot = await coachesCollection.where("codeData.code", isEqualTo: code).get();

  if (querySnapshot.docs.isNotEmpty) {
    // Assuming there's only one matching document, you can access it like this
    final DocumentSnapshot coachSnapshot = querySnapshot.docs.first;
    final Map<String, dynamic> coachData = coachSnapshot.data() as Map<String, dynamic>;

    // Get the current limit value
    int currentLimit = coachData["codeData"]["limit"];
    coachName = coachData["name"];
    coachEmail = coachData["email"];

    if (currentLimit > 0) {
      // Decrement the limit by 1
      setState(() {
        limitOk = true;
      });
      currentLimit--;

      // Update the Firestore document with the new limit
      await coachSnapshot.reference.update({
        "codeData.limit": currentLimit,
      });

      print("Code used successfully! New limit is $currentLimit");
    } else {
      print("The code limit has been reached.");
      setState(() {
        limitOk = false;
      });
      showDialog(
        context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('Inavlid Code', style: TextStyle(fontSize: 18),),
          content: const SizedBox(
            height: 100,
            child: Text("You entered an invalid code. Please entered a correct code or use the given code 'ab000'")
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("ok"))
          ],
      );});
    }
  } else {
    print("Code not found in any coach document.");
    showDialog(
        context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('Inavlid Code', style: TextStyle(fontSize: 18),),
          content: const SizedBox(
            height: 100,
            child: Text("You entered an invalid code. Please entered a correct code or use the given code 'ab000'.")
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("ok"))
          ],
      );});
  }
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(child: 
        SizedBox(width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/logo.png",
              fit: BoxFit.cover,
              width: size.width/4,height: size.height/8,)),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:   [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppLocalizations.of(context)!.freeReport, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Unlock a personalized report for you and your coach for free by entering your coach code. Once submitted, we'll send you both an insightful report straight to your inbox.")),
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
                                hintText: " Your ${AppLocalizations.of(context)!.fullName}"
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
                                hintText: " ${AppLocalizations.of(context)!.number}"
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
                                hintText: " Your ${AppLocalizations.of(context)!.email}"
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
                                hintText: " ${AppLocalizations.of(context)!.confirmEmail}"
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
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: codeConfirm,
                              validator:(value) {
                        if(value!.isEmpty){
                          return "Please enter a value";
                        }
                        else if (value != code.text) {
                          return 'Please confirm your code';
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
                                hintText: " Confirm Code"
                              ),
                            ),
                          ],
                        )
                        ),
                        const SizedBox(height: 30,),
                      //   const Text("Don't have a free code?"),
                      //   ElevatedButton(
                      //     onPressed: (){},
                      //     style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                      //       shape: RoundedRectangleBorder( //to set border radius to button
                      // borderRadius: BorderRadius.circular(50)
                      //           ),
                      //   ),
                      //      child: Text(AppLocalizations.of(context)!.contact) ),
                        
                        // const SizedBox(height: 30,),
                        // const Text("The Code will be given by the coach to its clients, and it will allow users to get the result for free and also will send the result to the email associated with the coach.",
                        // textAlign: TextAlign.center,
                        // ),
                        ElevatedButton(
                          onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              if(code.text != "ab000"){
                                //await markCodeAsFalse(code.text);
                               await  useCoachCode(code.text);
                              }
                              if(limitOk){
                              await sendEmail(email.text, "", false,context);
                              await sendEmail(coachEmail, "", true,context);
                              }else if(code.text == "ab000"){
                              await sendEmail(email.text, "", false,context);
                              await sendEmail(coachEmail, "", true,context);
                              }
                              Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(uid: widget.uid) ,), (route) => false);
    });
                            }
                          }, 
                          style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                          child: isLoading? const CircularProgressIndicator() : const Text("Get your free results") ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Don't have a code? Enter 'ab000' and a coach from our team will contact you", textAlign: TextAlign.center,),
              ),
              // ElevatedButton(onPressed: (){
              //  markCodeAsFalse("ab1");
              // }, child: const Text("Test"))
          ],
        ),
        )
        ),
      ),
    );
  }
}