// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
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
  bool isHundred = false;
  String code = "";
  bool isLoading = false;
  int limit = 0;

  Future<void> addCoachToFirestore(String name, String email, String password, String package,String code) async {
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    DocumentReference coachRef = firestoreInstance.collection("coaches").doc();
    Map<String, dynamic> coachData = {
      "name": name,
      "email": email,
      "package": package,
      "password":password,
      "codeData": {"code":code,"limit":limit,},
    };
    await coachRef.set(coachData);
   
    await sendEmail(email,password ,context);
    setState(() {
      isLoading = false;
      _name.clear();
      _email.clear();
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.emailSentSuccessfully);
    });
  } catch (e) {
    print("Error adding coach to Firestore: $e");
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> sendEmail(
    String recipientEmail, String pass ,BuildContext context) async {
    String userName2 = "Team@MyTrueNorthPath.com";
    final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = AppLocalizations.of(context)!.welcomeCoach
      ..html = AppLocalizations.of(context)!.languageName == "Spanish"? 
      """
Querido <b>${_name.text}</b>,<br>

Nos complace darte la bienvenida a True North, la aplicación que empodera a las personas para evaluar y mejorar su calidad de vida a través de una serie de preguntas que invitan a la reflexión. Como coach, desempeñas un papel fundamental al guiar y apoyar a nuestros usuarios en sus procesos de crecimiento personal.<br><br>

Para comenzar, queremos proporcionarte información importante:<br><br>

- Tu Código de Coach:<b>$code</b><br>
- Tu Contraseña del Panel de Coach:<b>$pass</b><br><br>

Así es cómo puedes acceder a tu cuenta de Coach en True North:<br>

1. Descarga la aplicación True North desde la tienda de aplicaciones de tu dispositivo (iOS/Android).<br>
2. Abre la aplicación y toca "Panel de Coach" en la pantalla de bienvenida.<br>
3. Ingresa tu Código de Coach y Contraseña.<br>
4. Una vez que hayas iniciado sesión, tendrás acceso a tu panel de coaching.<br><br>

Nuestra plataforma está diseñada para hacer que el coaching sea una experiencia fluida y enriquecedora tanto para ti como para tus clientes. Tendrás las herramientas e ideas necesarias para guiar a las personas hacia una mejor calidad de vida.<br><br>

Si tienes alguna pregunta, enfrentas algún desafío o necesitas ayuda con tu cuenta o tus responsabilidades como coach, no dudes en ponerte en contacto con nuestro equipo de soporte en <a href="mailto:Team@MyTrueNorthPath.com">Team@MyTrueNorthPath.com</a>. Estamos dedicados a brindarte un soporte excepcional y garantizar tu éxito en nuestra plataforma.<br><br>

Gracias por elegir True North como tu plataforma de coaching. Estamos emocionados de tenerte a bordo y esperamos tener un impacto positivo en las vidas de nuestros usuarios juntos.<br><br>

Atentamente,<br>
El Equipo de True North<br>
<a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a>
      """
      :"""
Dear <b>${_name.text}</b>,<br><br>

We are delighted to welcome you to True North, the app that empowers individuals to assess and improve their life quality through a series of thought-provoking questions. As a coach, you play a pivotal role in guiding and supporting our users on their personal growth journeys.<br>

To get started, we want to provide you with some important things:<br><br>

- Your Coach Code: <b>$code</b><br>
- Your Coach Panel Password: <b>$pass</b><br><br>

Here's how to access your True North Coach account:<br>

1. Download the True North app from your device's app store (iOS/Android).<br>
2. Open the app and tap on "Coach Panel" on the welcome screen.<br>
3. Enter your Coach Code and Password.<br>
4. Once logged in, you will gain access to your coaching dashboard.<br><br>

Our platform is designed to make coaching a seamless and enriching experience for both you and your clients. You'll have the tools and insights needed to guide individuals toward a better quality of life.<br><br>

If you have any questions, face any challenges, or need assistance with your account or coaching responsibilities, please don't hesitate to contact our support team at <a href="mailto:Team@MyTrueNorthPath.com">Team@MyTrueNorthPath.com</a>. We are dedicated to providing you with exceptional support and ensuring your success on our platform.<br><br>

Thank you for choosing True North as your coaching platform. We are excited to have you on board and look forward to making a positive impact on the lives of our users together.<br><br>

Best regards,<br>

True North Team<br>
<a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a>
               """;
      
    try {
      await send(message, smtpServer2);
      Navigator.of(context).pop();
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
  
  const codeLength = 8; // Generates an 8-character code
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


String generatePassword() {
  const String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%* ';
  final Random random = Random();
  String result = '';

  for (int i = 0; i < 6; i++) {
    final int randomIndex = random.nextInt(characters.length);
    result += characters[randomIndex];
  }

  return result;
}

  @override
  Widget build(BuildContext context) {
    String password = generatePassword();
    String selectedPackage = '50 Code Package';
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.addCoach),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                          labelText: AppLocalizations.of(context)!.name,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseEnterName;
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
                          labelText: AppLocalizations.of(context)!.coachEmail,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.pleaseEnterEmail;
                          }
                          else if(!value.contains("@")){
                            return AppLocalizations.of(context)!.pleaseEnterEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.package, style: const TextStyle(fontSize: 16, ),),
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
                   isLoading = true;
                   code = uniqueCode;
                   if(selectedPackage == "50 Code Package"){
                    limit = 50;
                   }else{
                    limit = 100;
                   }
                 });
                 addCoachToFirestore(_name.text.trim(),_email.text.trim(), password,selectedPackage,code);
                }
              }, child: isLoading? const CircularProgressIndicator() :Text(AppLocalizations.of(context)!.addCoach),),
              const SizedBox(height: 20,),
              Text(AppLocalizations.of(context)!.addCoachText),
            ],
          ),
        ),
      )
    );
  }
}