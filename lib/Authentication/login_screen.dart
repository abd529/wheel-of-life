// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:com.ezeelogix.truenorth/Screens/coach_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../Models/login_VM.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login";

  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsCheck = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoggingIn = false;
  final LoginViewModel _loginVM = LoginViewModel();
  String errMsg = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(),
                ),
                    Column(
                      children: [
                        Image.asset(
                         "assets/logo.png",
                          width: size.width/1.6,
                          height: size.height/5,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
              Text(AppLocalizations.of(context)!.signInToAdminPanel, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text(AppLocalizations.of(context)!.welcomeBackAdmin, style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 44,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                right:   BorderSide(width: 1.0, color: Colors.black),
                              ),
                          ),
                          child: const Icon(Icons.email_outlined)),
                      ),
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    controller: _passwordController,
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
                      labelText: 'Password',
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          obsCheck =!obsCheck;
                        });
                      }, icon: Icon( obsCheck? Icons.visibility : Icons.visibility_off))
                    ),
                    obscureText: !obsCheck,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  Text(errMsg, style: const TextStyle(color: Colors.red)),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextButton(child: Text("Forgot Password?"),onPressed: (){
                  //     Navigator.of(context).pushNamed(ForgotPassword.routeName);
                  //   }, )),
                  // const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: _isLoggingIn ? null : () async{
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoggingIn = true;
                          });
                           bool isLoggedIn = await _loginVM.login(_emailController.text, _passwordController.text);
                           if(isLoggedIn){
                             Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (ctx) => CoachesScreen()),(Route<dynamic> route) => false);
                           }else{
                           setState(() {
                          _isLoggingIn = false;  
                          errMsg = _loginVM.message;
                          });
                         }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/4, size.height/40, size.width/4, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),),
                      child: _isLoggingIn
                        ? const CircularProgressIndicator()
                        : Text(AppLocalizations.of(context)!.signin),  
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SignupScreen()),
                  //     );
                  //   },
                  //   child: const Text('Don\'t have an account? Sign up here'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
