// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:com.ezeelogix.truenorth/Screens/coach_filter.dart';
import 'package:com.ezeelogix.truenorth/Screens/free_report.dart';
import 'package:com.ezeelogix.truenorth/Screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:graphic/graphic.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WheelOfLife extends StatefulWidget {
  final adjustData;
  const WheelOfLife({super.key, this.adjustData});

  @override
  State<WheelOfLife> createState() => _WheelOfLifeState();
}

class _WheelOfLifeState extends State<WheelOfLife> {
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(double amount, String route) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(route);
    } catch (err) {
      throw Exception(err);
    }
  }

  void displayPaymentSheet(String route) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.of(context).pushNamed(route);
                      }, child: Text("Next")),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
        child: 
        Padding(
              padding: const EdgeInsets.all(05),
              child: Column(
                children: [
                  const Text("Your Wheel of life", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  Card(
                    child: Image.asset(
                         "assets/dummy_graph.jpg",
                          width: size.width/1.8,
                          height: size.height/8,
                          fit: BoxFit.cover,
                        ), 
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   width: size.width-30,
                    //   height: 300,
                    //   child:
                    //    Chart(
                    //     data: widget.adjustData,
                    //     variables: {
                    //       'index': Variable(
                    //         accessor: (Map map) => map['index'].toString(),
                    //       ),
                    //       'type': Variable(
                    //         accessor: (Map map) => map['type'] as String,
                    //       ),
                    //       'value': Variable(
                    //         accessor: (Map map) => map['value'] as num,
                    //       ),
                    //     },
                    //     marks: [
                    //       LineMark(
                    //         position:
                    //             Varset('index') * Varset('value') / Varset('type'),
                    //         shape: ShapeEncode(value: BasicLineShape(loop: true)),
                    //         color: ColorEncode(
                    //             variable: 'type', values: Defaults.colors10),
                    //       )
                    //     ],
                    //     coord: PolarCoord(),
                    //     axes: [
                    //       Defaults.circularAxis,
                    //       Defaults.radialAxis,
                    //     ],
                    //     selections: {
                    //       'touchMove': PointSelection(
                    //         on: {
                    //           GestureType.scaleUpdate,
                    //           GestureType.tapDown,
                    //           GestureType.longPressMoveUpdate
                    //         },
                    //         dim: Dim.x,
                    //         variable: 'index',
                    //       )
                    //     },
                    //     tooltip: TooltipGuide(
                    //       anchor: (_) => Offset.zero,
                    //       align: Alignment.bottomRight,
                    //       multiTuples: true,
                    //       variables: ['type', 'value'],
                    //     ),
                    //     crosshair: CrosshairGuide(followPointer: [false, true]),
                    //   ),
                    // ),
                    //   ],
                    // ),
                  ),
                  const Text("Do you want us to email the result to you for only \$1.99", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),),
                    onPressed: ()async{
                      //await makePayment(1.99, VerifyEmail.routeName);
                      Navigator.of(context).pushNamed(VerifyEmail.routeName);
                    }, child: const Text("Get email for \$1.99")),
                  const SizedBox(height: 30),
                  const Text("Get email and get contacted with certified coach", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),),
                    onPressed: ()async{
                      //await makePayment(2.99,"");
                      Navigator.of(context).pushNamed(CoachFilter.routeName);
                    }, child: const Text("Get email & Coach for \$2.99")),
                  const SizedBox(height: 30),
                  const Text("Send me and my coach an email for free", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 10),
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width/6, size.height/40, size.width/6, size.height/40),
                        shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(50)
                            ),),
                    onPressed: (){
                      Navigator.of(context).pushNamed(FreeReport.routeName);
                    }, child: const Text("Send email to me and my coach ")),  
                ],
              ),
            ),
        ),
      ),
    );
  }
}