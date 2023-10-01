import 'package:com.ezeelogix.truenorth/Models/coach_model.dart';
import 'package:com.ezeelogix.truenorth/Screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CoachDetailScreen extends StatefulWidget {
  final CoachModel coach;

  const CoachDetailScreen({super.key, required this.coach});

  @override
  State<CoachDetailScreen> createState() => _CoachDetailScreenState();
}

class _CoachDetailScreenState extends State<CoachDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailConfirmController = TextEditingController();
  bool isLoading = false;

  Future<void> sendEmail(
    String recipientEmail, String messageMail, BuildContext context) async {
      setState(() {
        isLoading = true;
      });
    String userName2 = "Team@MyTrueNorthPath.com";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = "Your coach code is here"
      ..html = """
               Dear ${nameController.text},<br>
               I hope this message finds you well. We value your commitment to personal growth<br>
               and development, and that's why we are excited to invite you to complete an<br>
               evaluation of your True North. This insightful assessment will pave the way for a<br>
               meaningful discussion with your coach, ${widget.coach.name}, as we delve into the details<br>
               of your journey towards self-discovery.<br><br>
              
              To get started, simply follow these easy steps:<br><br>

                  Click on the link provided below to access the True North evaluation:<br>
                  <a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a><br>
                  Download the (Apple) or (Google) app, depending on your device.<br>
                  Follow the on-screen instructions to complete the evaluation.<br>
                  When prompted, use the following code: <b>${widget.coach.code["code"]}</b><br><br>

              By using this code, you'll gain complimentary access to the assessment, and your coach<br>
              will receive a copy of your results to facilitate a more informed and productive<br>
              discussion.<br><br>

              We sincerely appreciate your trust in us as we work together to help you uncover<br>
              your deeper desires and unlock your true potential. Your journey towards self-discovery<br>
              is a remarkable one, and we are privileged to be a part of it.<br><br>

              If you have any questions or need assistance along the way, please do not hesitate<br>
              to reach out to us. We are here to support you every step of the way.<br><br>

              Thank you for your dedication to personal growth, and we look forward to embarking 
              on this enlightening journey with you.<br><br>

              Warm regards,<br>
              My True North App Team<br>
              <a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a>
    
               """;
      
    try {
      await send(message, smtpServer2);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        setState(() {
        isLoading = false;
      });
      }else{
        setState(() {
        isLoading = false;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen(),), (route) => false);
      }, child: const Icon(Icons.logout)),
      appBar: AppBar(
        title: const Text('Coach Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Name: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.email,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Package: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.package,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'Code: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.code["code"],
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Text(
                    'limit: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.limit.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Send this coach code to a user", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return"Please enter user's name";
                        }else{ return null;}
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
                                    child: const Icon(Icons.person)),
                                ),
                                labelText: 'Name',
                              ),
                      ),
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value!.isEmpty){
                          return"Please enter an email";
                        }
                        else if(!value.contains("@")){
                          return "Please enter a valid email";
                        }else{ return null;}
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
                                    child: const Icon(Icons.email)),
                                ),
                                labelText: 'Email',
                              ),
                      ),
                      TextFormField(
                      controller: emailConfirmController,
                      validator: (value){
                        if(value!.isEmpty){
                          return"Please enter your email";
                        }
                        else if(!value.contains("@")){
                          return "Please enter a valid email";
                        }else if(value != emailController.text){
                          return "Please confirm your email";
                        }
                        else{ return null;}
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
                                    child: const Icon(Icons.email)),
                                ),
                                labelText: 'Confirm Email',
                              ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                                ),),
                onPressed: ()async{
                if(_formKey.currentState!.validate()){
                  await sendEmail(emailController.text.trim(),"",context);
                  Fluttertoast.showToast(msg: "Email Sent");
                  nameController.clear();
                  emailController.clear();
                  emailConfirmController.clear();
                }
              }, child: isLoading? const CircularProgressIndicator() : const Text("Send Code")),
            )
          ],
        ),
      ),
    );
  }
}
