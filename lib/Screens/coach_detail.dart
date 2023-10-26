// ignore_for_file: use_build_context_synchronously

import 'package:com.ezeelogix.truenorth/Models/coach_model.dart';
import 'package:com.ezeelogix.truenorth/Screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


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
      if(AppLocalizations.of(context)!.languageName == "Spanish"){
        String userName2 = "Team@MyTrueNorthPath.com";
        final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
        final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = AppLocalizations.of(context)!.coachCodeHere
      ..html = 
      """ 
      <p> Estimado ${nameController.text},<br>
    Espero que este mensaje te encuentre bien. Valoramos tu compromiso con el crecimiento<br>
    personal y el desarrollo, por eso estamos emocionados de invitarte a completar una<br>
    evaluación de tu Verdadero Norte. Esta valiosa evaluación allanará el camino para una<br>
    discusión significativa con tu coach, ${widget.coach.name}, mientras exploramos los detalles<br>
    de tu viaje hacia el autodescubrimiento.<br><br>
    
    Para comenzar, simplemente sigue estos sencillos pasos:<br><br>
    
    Haz clic en el enlace proporcionado a continuación para acceder a la evaluación de True North:<br>
    <a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a><br>
    Descarga la aplicación (Apple) o (Google), según tu dispositivo.<br>
    Sigue las instrucciones en pantalla para completar la evaluación.<br>
    Cuando se te solicite, utiliza el siguiente código: <b>${widget.coach.code["code"]}</b><br><br>
    
    Al utilizar este código, obtendrás acceso gratuito a la evaluación, y tu coach<br>
    recibirá una copia de tus resultados para facilitar una discusión más informada y productiva.<br><br>
    
    Apreciamos sinceramente tu confianza en nosotros mientras trabajamos juntos para descubrir<br>
    tus deseos más profundos y desbloquear tu verdadero potencial. Tu viaje hacia el autodescubrimiento<br>
    es realmente notable, y tenemos el privilegio de ser parte de él.<br><br>
    
    Si tienes alguna pregunta o necesitas asistencia en el camino, por favor no dudes<br>
    en ponerte en contacto con nosotros. Estamos aquí para apoyarte en cada paso del camino.<br><br>
    
    Gracias por tu dedicación al crecimiento personal, y esperamos embarcarnos en este iluminador<br>
    viaje contigo.<br><br>
    
    Saludos cordiales,<br>
    El Equipo de My True North App<br>
    <a href="https://www.mytruenorthpath.com">MyTrueNorthPath.com</a>
</p>

      """;
      try {
      await send(message, smtpServer2);
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.emailSentSuccessfully);
                  nameController.clear();
                  emailController.clear();
                  emailConfirmController.clear();
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
      else{
        String userName2 = "Team@MyTrueNorthPath.com";
        final smtpServer2 = SmtpServer("smtp.titan.email",
        username: "Team@MyTrueNorthPath.com",
        password: "P@ki15t@n!",
        port: 465,
        ssl: true);
    final message = Message()
      ..from = Address(userName2, "True North")
      ..recipients.add(recipientEmail)
      ..subject = AppLocalizations.of(context)!.coachCodeHere
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
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.emailSentSuccessfully);
                  nameController.clear();
                  emailController.clear();
                  emailConfirmController.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashScreen(),), (route) => false);
      }, child: const Icon(Icons.logout)),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.coachDetails),
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
                  Text(
                    '${AppLocalizations.of(context)!.name}: ',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Text(
                    '${AppLocalizations.of(context)!.email}:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Text(
                    '${AppLocalizations.of(context)!.package}: ',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Text(
                    '${AppLocalizations.of(context)!.code}: ',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                   Text(
                    '${AppLocalizations.of(context)!.code}: ',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.coach.limit.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.sendToUser, style:const TextStyle(fontWeight: FontWeight.bold),),
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
                          return AppLocalizations.of(context)!.pleaseEnterUserName ;
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
                                labelText: AppLocalizations.of(context)!.name,
                              ),
                      ),
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value!.isEmpty){
                          return AppLocalizations.of(context)!.pleaseEnterEmail;
                        }
                        else if(!value.contains("@")){
                          return AppLocalizations.of(context)!.pleaseEnterEmail;
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
                                labelText: AppLocalizations.of(context)!.email,
                              ),
                      ),
                      TextFormField(
                      controller: emailConfirmController,
                      validator: (value){
                        if(value!.isEmpty){
                          return AppLocalizations.of(context)!.pleaseEnterEmail;
                        }
                        else if(!value.contains("@")){
                          return AppLocalizations.of(context)!.pleaseEnterEmail ;
                        }else if(value != emailController.text){
                          return AppLocalizations.of(context)!.pleaseEnterEmail;
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
                                labelText: AppLocalizations.of(context)!.confirmEmail,
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
                }
              }, child: isLoading? const CircularProgressIndicator() : Text(AppLocalizations.of(context)!.sendCode, textAlign: TextAlign.center,)),
            )
          ],
        ),
      ),
    );
  }
}
