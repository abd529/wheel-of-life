// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages
import 'package:blur/blur.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'dart:convert';
import 'dart:ui' as ui;
import '../Screens/coach_filter.dart';
import '../Screens/free_report.dart';
import '../Screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:graphic/graphic.dart';
import 'package:http/http.dart' as http;

class WheelOfLife extends StatefulWidget {
  final adjustData;
  final String userId;
  const WheelOfLife({super.key, this.adjustData, required this.userId});

  @override
  State<WheelOfLife> createState() => _WheelOfLifeState();
}

class _WheelOfLifeState extends State<WheelOfLife> {
  final GlobalKey globalKey = GlobalKey();
  Map<String, dynamic>? paymentIntent;

  Future<String> captureWidget() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final ref = FirebaseStorage.instance.ref().child("${widget.userId}image");
    await ref.putData(Uint8List.fromList(pngBytes));
    String downloadUrl = await ref.getDownloadURL();
    print("linkkkkkkkkkk $downloadUrl");
    return downloadUrl;
  }

  Future<String> fetchFileUrl(String fileName) async {
    // Create a reference to the file
    Reference fileRef = FirebaseStorage.instance.ref().child(fileName);

    // Get the download URL for the file
    String downloadUrl = await fileRef.getDownloadURL();

    return downloadUrl;
  }

  String fileUrl = "";
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(05),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.yourReport,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // ElevatedButton(onPressed: (){
                //   captureWidget();
                // }, child: const Text("post wheel")),
                SizedBox(
                  width: 400,
                  height: 300,
                  child: Card(
                    child:
                        // Image.asset(
                        //      "assets/dummy_graph.jpg",
                        //       width: size.width/1.8,
                        //       height: size.height/8,
                        //       //fit: BoxFit.cover,
                        //     ),
                        Blur(
                      blur: 2.5,
                      child: RepaintBoundary(
                        key: globalKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: size.width - 30,
                              height: 300,
                              child: Chart(
                                data: widget.adjustData,
                                variables: {
                                  'index': Variable(
                                    accessor: (Map map) =>
                                        map['index'].toString(),
                                  ),
                                  'type': Variable(
                                    accessor: (Map map) =>
                                        map['type'] as String,
                                  ),
                                  'value': Variable(
                                    accessor: (Map map) => map['value'] as num,
                                  ),
                                },
                                marks: [
                                  LineMark(
                                    position: Varset('index') *
                                        Varset('value') /
                                        Varset('type'),
                                    shape: ShapeEncode(
                                        value: BasicLineShape(loop: true)),
                                    color: ColorEncode(
                                        variable: 'type',
                                        values: Defaults.colors10),
                                  )
                                ],
                                coord: PolarCoord(),
                                axes: [
                                  Defaults.circularAxis,
                                  Defaults.radialAxis,
                                ],
                                selections: {
                                  'touchMove': PointSelection(
                                    on: {
                                      GestureType.scaleUpdate,
                                      GestureType.tapDown,
                                      GestureType.longPressMoveUpdate
                                    },
                                    dim: Dim.x,
                                    variable: 'index',
                                  )
                                },
                                tooltip: TooltipGuide(
                                  anchor: (_) => Offset.zero,
                                  align: Alignment.bottomRight,
                                  multiTuples: true,
                                  variables: ['type', 'value'],
                                ),
                                crosshair: CrosshairGuide(
                                    followPointer: [false, true]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.packageone,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width / 6,
                          size.height / 40, size.width / 6, size.height / 40),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () async {
                      await makePayment(
                        2.toString(),
                      );
                      fileUrl = await fetchFileUrl(widget.userId);
                      imgUrl = await captureWidget();
                      print('URLzzz: $fileUrl $imgUrl');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VerifyEmail(fileUrl: fileUrl, imgUrl: imgUrl),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.packageOneButton,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.packagetwo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width / 6,
                          size.height / 40, size.width / 6, size.height / 40),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () async {
                      await makePayment(3.toString());
                      fileUrl = await fetchFileUrl(widget.userId);
                      imgUrl = await captureWidget();
                      print('URLzzz: $fileUrl $imgUrl');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CoachFilter(fileUrl: fileUrl, imgUrl: imgUrl),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.packageTwoButton,
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.packagethree,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(size.width / 6,
                          size.height / 40, size.width / 6, size.height / 40),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: () async {
                      fileUrl = await fetchFileUrl(widget.userId);
                      imgUrl = await captureWidget();
                      print('URLzzz: $fileUrl $imgUrl');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            FreeReport(fileUrl: fileUrl, imgUrl: imgUrl),
                      ));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.packageThreeButton,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String price) async {
    try {
      paymentIntent = await createPaymentIntent(price, 'USD');

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
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
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
}
