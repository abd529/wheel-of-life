// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  List<String> newCodes = [];
  bool isLoading = false;

  Future<void> addCoachToFirestore(String name, String email, String package,List<String> codes) async {
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    DocumentReference coachRef = firestoreInstance.collection("coaches").doc();
    Map<String, dynamic> coachData = {
      "name": name,
      "email": email,
      "package": package,
      "codes": { for (var code in codes) code : true },
    };
    await coachRef.set(coachData);
    String lastCode = codes.isNotEmpty ? codes.last : "ab0";
    DocumentReference lastCodeRef = firestoreInstance.collection("last_code").doc("latest");
    await lastCodeRef.set({"lastCode": lastCode});
    print("Coach added to Firestore successfully!");
    await sendEmail(email,"Hey, Welcome to True North Coach, Here are your codes\n$codes",context);
    setState(() {
      isLoading = false;
      _name.clear();
      _email.clear();
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
    String userName2 = "gesconvsgar@ezeelogix.com";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "gesconvsgar@ezeelogix.com",
        password: "ges23@conv",
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



Future<void> generateAndSaveCodes(bool generate100) async {
  newCodes = [];
  setState(() {
    isLoading = true;
  });
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    DocumentReference lastCodeRef = firestoreInstance.collection("last_code").doc("latest");
    DocumentSnapshot lastCodeSnapshot = await lastCodeRef.get();
    String lastCode = (lastCodeSnapshot.data() as Map<String, dynamic>)["lastCode"] ?? "ab0";
    int lastCodeNumber = int.parse(lastCode.substring(2));
    int codeRange = generate100 ? 100 : 50;
    for (int i = lastCodeNumber + 1; i <= lastCodeNumber + codeRange; i++) {
      String newCode = 'ab$i';
      newCodes.add(newCode);
    }
    String latestCode = 'ab${lastCodeNumber + codeRange}';
    await lastCodeRef.set({"code": latestCode});
    print("Generated Codes: $newCodes");
    addCoachToFirestore(_name.text, _email.text, selectedPackage, newCodes);
  } catch (e) {
    print("Error generating and saving codes: $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Add Coach", style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold
                ),),
              ),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)
                ),
                onPressed: (){
                if(_formKey.currentState!.validate()){
                  generateAndSaveCodes(isHundred);
                }
              }, child: isLoading? const CircularProgressIndicator() :const Text("Add Coach")),
              const Text("By adding the coach, codes will be generated, saved in backend and sent to the coach email"),
            ],
          ),
        ),
      )
    );
  }
}