import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmail extends StatefulWidget {
  static const routeName = "verify-name";
  const VerifyEmail({super.key});

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
            Image.asset(
                         "assets/logo.png",
                          width: size.width/1.5,
                          height: size.height/4.5,
                          fit: BoxFit.contain,
                        ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:   [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Verify Email", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Verify your email ")),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
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
                                hintText: " Full Name"
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
                           
                          ],
                        )
                        ),
                        const SizedBox(height: 30,),
                        ElevatedButton(
                          onPressed: (){
                            if(_formKey.currentState!.validate()){}
                          },
                          style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                           child: const Text("Send Me Report")),
                        
                        const SizedBox(height: 30,),
                        const Text("I’ll be contacted by a professional coach to give me my result of the Wheel of Life without any opbligation.",
                        textAlign: TextAlign.center,
                        ),
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