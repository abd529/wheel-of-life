// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:com.ezeelogix.truenorth/Models/coach_model.dart';
import 'package:com.ezeelogix.truenorth/Screens/coach_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';



class CoachPanel extends StatefulWidget {
  const CoachPanel({super.key});

  @override
  State<CoachPanel> createState() => _CoachPanelState();
}

class _CoachPanelState extends State<CoachPanel> {
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CoachModel? coach;
  bool isLoading = false;
  String errText = "";
  bool obsCheck1 = false;
  bool obsCheck2 = false;

Future<CoachModel?> codeAndPassCheck(String code, String password) async {
  setState(() {
    isLoading = true;
  });
  // Reference to the "coaches" collection in Firestore
  CollectionReference coachesCollection =
      FirebaseFirestore.instance.collection("coaches");

  try {
    // Query Firestore to find documents where "codeData.code" equals the provided code
    QuerySnapshot querySnapshot = await coachesCollection
        .where("codeData.code", isEqualTo: code)
        .get();

    // Check if there are any documents that match the code query
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming codes are unique) and convert it to a CoachModel
      DocumentSnapshot codeDocument = querySnapshot.docs.first;
      Map<String, dynamic> codeData = codeDocument.data() as Map<String, dynamic>;

      // Check if the password matches the one in the document
      if (codeData.containsKey("password") && codeData["password"] == password) {
        setState(() {
          isLoading = false;
        });
        return CoachModel.fromSnapshot(codeDocument);
      } else {
        // Password doesn't match
        setState(() {
          isLoading = false;
        });
        return null; // Return null to indicate password mismatch
      }
    } else {
      // Code is not present in Firestore
      setState(() {
        isLoading = false;
      });
      return null; // Return null to indicate that the code was not found
    }
  } catch (e) {
    // Handle any errors, e.g., Firebase-related errors
    setState(() {
      isLoading = false;
    });
    print("Error fetching code data: $e");
    return null; // You can choose to handle the error differently
  }
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                             "assets/logo.png",
                              width: size.width/1.6,
                              height: size.height/5,
                              fit: BoxFit.contain,
                            ),
                ),
                const SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.signInToCoachPanel, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text(AppLocalizations.of(context)!.welcomeBackCoach, style: const TextStyle(color: Colors.grey),),
                const SizedBox(height: 44,),
                Text(AppLocalizations.of(context)!.enterCode, style: const TextStyle(fontWeight: FontWeight.bold),),
                Form(
                key: _formKey,  
                child: 
                Column(
                  children: [
                    TextFormField(
                      controller: codeController,
                      validator: (value){
                        if(value!.isEmpty){
                          return AppLocalizations.of(context)!.pleaseEnterCode;
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                decoration: const BoxDecoration(
                                      border: Border(
                                        right:   BorderSide(width: 1.0, color: Colors.black),
                                      ),
                                  ),
                                child: const Icon(Icons.lock_open_rounded)),
                            ),
                            labelText: 'Code',
                          ),
                      ),
                    TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                        child: const Icon(Icons.lock_open_rounded)),
                    ),
                      labelText: 'Password',
                       suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        obsCheck1 =!obsCheck1;
                      });
                    }, icon: Icon( obsCheck1? Icons.visibility : Icons.visibility_off))
                    ),
                    obscureText: !obsCheck1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),  
                  ],
                )),
                Text(errText, style: const TextStyle(color: Colors.red),),
                  const SizedBox(height:50),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                            ),),
                      onPressed: ()async{
                      if(_formKey.currentState!.validate()){
                        CoachModel? coach  = await codeAndPassCheck(codeController.text, passController.text);
                     if(coach != null){
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>CoachDetailScreen(coach: coach)), (route) => false);
                     }
                     else if(coach ==  null){
                      setState(() {
                        errText = AppLocalizations.of(context)!.coachCodeNotExist;
                      });
                     }
                      }
                    }, child: isLoading? const CircularProgressIndicator(): const Text("Sign In")),
                  ),
              ],
            ),
          )
        ),
      )
    );
  }
}