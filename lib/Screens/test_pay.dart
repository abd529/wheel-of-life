// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';

// class HomeScreen1 extends StatefulWidget {  final String price;

//   const HomeScreen1({Key? key, required this.price}) : super(key: key);

//   @override
//   _HomeScreen1State createState() => _HomeScreen1State();
// }

// class _HomeScreen1State extends State<HomeScreen1> {
//   Map<String, dynamic>? paymentIntent;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Payment'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton(
//               child: const Text('Make Payment'),
//               onPressed: () async {
//                 await makePayment();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
