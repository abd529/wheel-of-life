// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AddCoach extends StatefulWidget {
  const AddCoach({super.key});

  @override 
  State<AddCoach> createState() => _AddCoachState();
}

class _AddCoachState extends State<AddCoach> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedPackage = '50 Code Package';
  bool isHundred = false;
  String code = "";
  bool isLoading = false;
  int limit = 0;

  Future<void> addCoachToFirestore(String name, String email, String package,String code) async {
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    DocumentReference coachRef = firestoreInstance.collection("coaches").doc();
    Map<String, dynamic> coachData = {
      "name": name,
      "email": email,
      "package": package,
      "codeData": {"code":code,"limit":limit},
    };
    await coachRef.set(coachData);
   
    await sendEmail(email,"Welcome to True North, Coach. Here is your code\n$code",context);
    setState(() {
      isLoading = false;
      _name.clear();
      _email.clear();
      Fluttertoast.showToast(msg: "Email sent succesfully");
    });
  } catch (e) {
    print("Error adding coach to Firestore: $e");
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> sendEmail(
    String recipientEmail, String messageMail, BuildContext context) async {
    String userName2 = "Team@MyTrueNorthPath.com";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = "Welcome Coach"
      ..text = messageMail;
      
    try {
      await send(message, smtpServer2);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }



String generateUniqueCode() {
  final now = DateTime.now();
  final year = now.year.toString();
  final random = Random();
  
  final codeLength = 8; // Generates an 8-character code
  final code = StringBuffer();
  
  // Add the last 2 digits of the current year to the code
  code.write(year.substring(year.length - 2));
  
  // Add random alphabetic and numeric characters (remaining 6 digits) to complete the code
  for (int i = 2; i < codeLength; i++) {
    final characterSet = i % 2 == 0 ? 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' : '0123456789';
    code.write(characterSet[random.nextInt(characterSet.length)]);
  }

  return code.toString();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Coach"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: Text("Add Coach", style: TextStyle(
              //     fontSize: 20, fontWeight: FontWeight.bold
              //   ),),
              // ),
              Form(
              key: _formKey,  
              child: 
              Column(
                children: [
                TextFormField(
                  controller: _name,
                  decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                    right:   BorderSide(width: 1.0, color: Colors.black),
                                  ),
                              ),
                              child: const Icon(Icons.person)),
                          ),
                          labelText: 'Coach Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter coach name';
                          }
                          return null;
                        },
                      ),
              TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                    right:   BorderSide(width: 1.0, color: Colors.black),
                                  ),
                              ),
                              child: const Icon(Icons.email)),
                          ),
                          labelText: 'Coach Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter coach name';
                          }
                          else if(!value.contains("@")){
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Package", style: TextStyle(fontSize: 16, ),),
              DropdownButton<String>(
                value: selectedPackage,
                onChanged: (newValue) {
                  setState(() {
                    selectedPackage = newValue as String;
                    isHundred =  selectedPackage == '50 Code Package'? false: true;
                  });
                },
                items: <String>[
                  '50 Code Package',
                  '100 Code Package',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),        
              ],) ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)
                ),
                onPressed: (){
                if(_formKey.currentState!.validate()){
                 String uniqueCode =  generateUniqueCode();
                 setState(() {
                   code = uniqueCode;
                   if(selectedPackage == "50 Code Package"){
                    limit = 50;
                   }else{
                    limit = 100;
                   }
                 });
                 addCoachToFirestore(_name.text.trim(),_email.text.trim(),selectedPackage,code);
                }
              }, child: isLoading? const CircularProgressIndicator() :const Text("Add Coach")),
              const SizedBox(height: 20,),
              const Text("By adding the coach, codes will be generated, saved in backend and sent to the coach email"),
            ],
          ),
        ),
      )
    );
  }
}