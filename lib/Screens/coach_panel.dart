import 'package:com.ezeelogix.truenorth/Models/coach_model.dart';
import 'package:com.ezeelogix.truenorth/Screens/coach_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CoachPanel extends StatefulWidget {
  const CoachPanel({super.key});

  @override
  State<CoachPanel> createState() => _CoachPanelState();
}

class _CoachPanelState extends State<CoachPanel> {
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CoachModel? coach;
  bool isLoading = false;

Future<CoachModel?> codeCheck(String code) async {
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

    // Check if there are any documents that match the query
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming codes are unique) and convert it to a CoachModel
      setState(() {
    isLoading = false;
  });
      return CoachModel.fromSnapshot(querySnapshot.docs.first);
      
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
    print("Error fetching code data from Firestore: $e");
    return null; // You can choose to handle the error differently
  }
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                             "assets/logo.png",
                              width: size.width/1.6,
                              height: size.height/5,
                              fit: BoxFit.cover,
                            ),
                ),
                const SizedBox(height: 20,),
                const Text("Sign in to Coach Panel", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                const Text("Welcome Back Coach", style: TextStyle(color: Colors.grey),),
                const SizedBox(height: 44,),
                const Text("Enter Your Code", style: TextStyle(fontWeight: FontWeight.bold),),
                Form(
                key: _formKey,  
                child: 
                TextFormField(
                  controller: codeController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a code";
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
                  )),
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
                        CoachModel? coach  = await codeCheck(codeController.text);
                     if(coach != null){
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>CoachDetailScreen(coach: coach)), (route) => false);
                     }
                      }
                    }, child: isLoading? const CircularProgressIndicator(): const Text("Sign In")),
                  )
              ],
            ),
          )
        ),
      )
    );
  }
}