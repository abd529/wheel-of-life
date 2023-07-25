// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StripePayment3 extends StatefulWidget {
//   static const routeName = "stripe-pay";
//   const StripePayment3({super.key});

//   @override
//   State<StripePayment3> createState() => _StripePaymentState();
// }

// class _StripePaymentState extends State<StripePayment3> {
//   bool payCheck = false;
//   Map<String, dynamic>? paymentIntentData;
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text("Stripe Payment"),
//             ElevatedButton(
//                 onPressed: () async {
//                   print("hehhe");
//                   //await makePayment();
//                   print("hohoho");
//                 },
//                 child: Text("Pays"))
//           ]),
//     );
//   }
// }