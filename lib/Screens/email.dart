
// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../Authentication/google_signin_api.dart';

class EmailSend extends StatelessWidget {
  static const routeName = "email-send";
   EmailSend({super.key});
  late Future<int> statusCode ;

  void sendEmail(String recipientEmail, String messageMail, BuildContext context)async{
    final user = await GoogleAuthApi.signIn();
    String userName = "abdullahayaz529@gmail.com";
    String password = "lxivqayisxdamtfd";
    String token = "";
    final smtpServer = gmailSaslXoauth2(userName, token);
    final message = Message()..from=Address(userName,"Mail Service")..recipients.add(recipientEmail)..subject = "Mail"..text = "Message: $messageMail";
    try{
      await send(message, smtpServer);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: FittedBox(
          child: Text("Email send good"),
        ))
      );
    }catch(e){
      if(kDebugMode){
        print(e.toString());
      }
    }
  }

  signIn(){
    final _googleSignIn = GoogleSignIn();
    Future<GoogleSignInAccount?> login() =>_googleSignIn.signIn();
  }

  // Future<int> sendEmail(String name, String subject ,String email, String message)async{
  //   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  //   const serviceId = "service_s39rjkb";
  //   const templateId = "template_nkouyjm";
  //   const userId = "6M4uvdBz8ngpn9BD-";
  //   final response = await http.post(
  //     url,
  //     headers: {"Content-Type":"application/json"},
  //     body: json.encode({
  //       "service_id": serviceId,
  //       "template_id":templateId,
  //       'user_id': userId,
  //       'template_params': {
  //         'subject': subject,
  //         'reply_to': email,
  //         'name':name,
  //         'message': message
  //       }
  //     })
  //     );
  //     return response.statusCode;
  // }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("hehe"),),
          ElevatedButton(onPressed: ()async{
           await GoogleAuthApi.signIn();
          }, child: const Text("sign in")),
          ElevatedButton(onPressed: (){
            sendEmail("abdullahayaz529@gmail.com","heyyyyy", context);
          }, child: const Text("send email"))
        ],
      ),
    );
  }
}