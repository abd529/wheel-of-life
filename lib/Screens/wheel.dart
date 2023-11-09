// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages, use_build_context_synchronously, avoid_print
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../Models/stripservices.dart';
import '../Screens/free_report.dart';
import '../Screens/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:graphic/graphic.dart';

import '../Utilities/popup_loader.dart';

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
  String done = "";
  bool hasCompletedPurchase = false;

  Future<void> makePurchases(StoreProduct? package,
      ValueNotifier<bool> isWaiting, BuildContext context) async {
    try {
      isWaiting.value = true;
      CustomerInfo purchaserInfo =
          await Purchases.purchaseStoreProduct(package!);
      await Purchases.syncPurchases();
      if (purchaserInfo.entitlements.all["truenorth_1_report"]!.isActive) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerifyEmail(
            fileUrl: fileUrl,
            imgUrl: imgUrl,
            uid: widget.userId,
            isCoach: false,
            coachBadge: "",
            coachGen: "",
            coachLang: "",
          ),
        ));
      }
      print(purchaserInfo.activeSubscriptions);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => VerifyEmail(
          fileUrl: fileUrl,
          imgUrl: imgUrl,
          uid: widget.userId,
          isCoach: false,
          coachBadge: "",
          coachGen: "",
          coachLang: "",
        ),
      ));

      PopupLoader.hide();
      isWaiting.value = false;
    } catch (e) {
      var errorCode = e.toString();
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {}
      PopupLoader.hide();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => WheelOfLife(
                userId: widget.userId,
                adjustData: widget.adjustData,
              )));
      print(e);
      isWaiting.value = false;
    }
    isWaiting.value = false;
    return null;
  }

  // Future<String> captureWidget() async {
  //   final RenderRepaintBoundary boundary =
  //       globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  //   final ui.Image image = await boundary.toImage();

  //   final ByteData? byteData =
  //       await image.toByteData(format: ui.ImageByteFormat.png);

  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();

  //   final ref = FirebaseStorage.instance.ref().child("${widget.userId}image");
  //   await ref.putData(Uint8List.fromList(pngBytes));
  //   String downloadUrl = await ref.getDownloadURL();
  //   print("linkkkkkkkkkk $downloadUrl");
  //   setState(() {
  //     done = "done";
  //   });
  //   return downloadUrl;
  // }

  Future<String> fetchFileUrl(String fileName) async {
    // Create a reference to the file
    Reference fileRef = FirebaseStorage.instance.ref().child(fileName);

    // Get the download URL for the file
    String downloadUrl = await fileRef.getDownloadURL();
    setState(() {
      done = "done";
    });
    return downloadUrl;
  }

  String fileUrl = "";
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.yourReport,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // ElevatedButton(onPressed: (){
              //   captureWidget();
              // }, child: const Text("post wheel")),
              SizedBox(
                width: size.width - 10,
                height: size.height / 3,
                child: Card(
                  color: Colors.white,
                  child:
                      // Image.asset(
                      //      "assets/dummy_graph.jpg",
                      //       width: size.width/1.8,
                      //       height: size.height/8,
                      //       //fit: BoxFit.cover,
                      //     ),
                      Stack(
                    children: [
                      RepaintBoundary(
                        key: globalKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: size.width - 30,
                              height: size.height / 3.3,
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
                                    accessor: (Map map) => double.parse(
                                        map['value'].toStringAsFixed(1)),
                                  ),
                                },
                                marks: [
                                  LineMark(
                                    position: Varset('index') *
                                        Varset('value') /
                                        Varset('type'),
                                    shape: ShapeEncode(
                                        value: BasicLineShape(
                                      loop: true,
                                    )),
                                    color: ColorEncode(
                                        variable: 'type',
                                        values: Defaults.colors10),
                                  )
                                ],
                                coord: PolarCoord(),
                                axes: [
                                  Defaults.circularAxis,
                                  //Defaults.radialAxis,
                                ],
                                selections: {
                                  'touchMove': PointSelection(
                                    // on: {
                                    //   GestureType.scaleUpdate,
                                    //   GestureType.tapDown,
                                    //   GestureType.longPressMoveUpdate
                                    // },
                                    dim: Dim.x,
                                    variable: 'index',
                                  )
                                },
                                tooltip: TooltipGuide(
                                  anchor: (_) => Offset.zero,
                                  align: Alignment.bottomCenter,
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
                      Image.asset(
                        "assets/dummy_graph.jpg",
                        height: size.height / 3,
                        width: size.width - 10,
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.2),
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context)!.sampleWheelText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.packageone,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
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
                        if (hasCompletedPurchase) {
                          // If the purchase has already been completed, prevent further attempts
                          return;
                        }
                        PopupLoader.show();
                        fileUrl = await fetchFileUrl(widget.userId);
                        print('URLzzz: $fileUrl $imgUrl');

                        var items = [
                          {
                            "productPrice": 1.99,
                            "productName": "1.99 Package",
                            "qty": 1,
                          },
                        ];
                        if (Platform.isIOS) {
                          StoreProduct p = StoreProduct(
                              "truenorth_1_report",
                              "Buy this package to get detailed report in email",
                              "Get Report In Email",
                              1.99,
                              "1.99",
                              "USD");
                          ValueNotifier<bool> val = ValueNotifier(true);

                          makePurchases(p, val, context);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyEmail(
                              fileUrl: fileUrl,
                              imgUrl: imgUrl,
                              uid: widget.userId,
                              isCoach: false,
                              coachBadge: "",
                              coachGen: "",
                              coachLang: "",
                            ),
                          ));
                        } else {
                          PopupLoader.hide();
                          await StripeService.stripePaymentCheckout(
                              items, 500, context, mounted,
                              onSuccess: (String token) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VerifyEmail(
                                  fileUrl: fileUrl,
                                  imgUrl: imgUrl,
                                  uid: widget.userId,
                                  isCoach: false,
                                  coachBadge: "",
                                  coachGen: "",
                                  coachLang: ""),
                            ));
                            print("SUCCESS token:$token");
                          }, onCancel: () {
                            print("CANCEL");
                          }, onError: (e) {
                            print("ERROR ${e.toString()}");
                          });
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.packageOneButton,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),

              // const SizedBox(height: 30),
              // Text(
              //   AppLocalizations.of(context)!.packagetwo,
              //   textAlign: TextAlign.center,
              //   style: const TextStyle(fontSize: 16),
              // ),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       padding: EdgeInsets.fromLTRB(size.width / 6,
              //           size.height / 40, size.width / 6, size.height / 40),
              //       shape: RoundedRectangleBorder(
              //           //to set border radius to button
              //           borderRadius: BorderRadius.circular(50)),
              //     ),
              //     onPressed: () async {
              //       PopupLoader.show();
              //       fileUrl = await fetchFileUrl(widget.userId);
              //       imgUrl = await captureWidget();
              //       print('URLzzz: $fileUrl $imgUrl');
              //       PopupLoader.hide();
              //       var items = [
              //         {
              //           "productPrice": 2.99,
              //           "productName": "2.99 Package",
              //           "qty": 1,
              //         },
              //       ];
              //       await StripeService.stripePaymentCheckout(
              //           items, 500, context, mounted,
              //           onSuccess: (String token) {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) =>
              //               CoachFilter(fileUrl: fileUrl, imgUrl: imgUrl, uid: widget.userId),
              //         ));

              //         print("SUCCESS token:$token");
              //       }, onCancel: () {
              //         print("CANCEL");
              //       }, onError: (e) {
              //         print("ERROR ${e.toString()}");
              //       });
              //     },
              //     child: Text(
              //       AppLocalizations.of(context)!.packageTwoButton,
              //       textAlign: TextAlign.center,
              //     )),
              // const SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.packagethree}\n ${AppLocalizations.of(context)!.freeCodeText}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 15),
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
                        PopupLoader.show();
                        fileUrl = await fetchFileUrl(widget.userId);
                        print('URLzzz: $fileUrl $imgUrl');
                        PopupLoader.hide();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FreeReport(
                              fileUrl: fileUrl,
                              imgUrl: imgUrl,
                              uid: widget.userId),
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.packageThreeButton,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String price) async {
    try {
      //  paymentIntent = await createPaymentIntent(price, 'USD');

      //STEP 2: Initialize Payment Sheet
      // await Stripe.instance
      //     .initPaymentSheet(
      //         paymentSheetParameters: SetupPaymentSheetParameters(
      //             paymentIntentClientSecret: paymentIntent![
      //                 'client_secret'], //Gotten from payment intent
      //             style: ThemeMode.dark,
      //             merchantDisplayName: 'Ikay'))
      //     .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    // try {
    // await Stripe.instance.presentPaymentSheet().then((value) {
    //   showDialog(
    //       context: context,
    //       builder: (_) => AlertDialog(
    //             content: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Icon(
    //                   Icons.check_circle,
    //                   color: Colors.green,
    //                   size: 100.0,
    //                 ),
    //                 SizedBox(height: 10.0),
    //                 Text("Payment Successful!"),
    //               ],
    //             ),
    //           ));

    //       paymentIntent = null;
    //     }).onError((error, stackTrace) {
    //       throw Exception(error);
    //     });
    //   } on StripeException catch (e) {
    //     print('Error is:---> $e');
    //     AlertDialog(
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Row(
    //             children: const [
    //               Icon(
    //                 Icons.cancel,
    //                 color: Colors.red,
    //               ),
    //               Text("Payment Failed"),
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   } catch (e) {
    //     print('$e');
    //   }
    // }

    // createPaymentIntent(String amount, String currency) async {
    //   try {
    //     //Request body
    //     Map<String, dynamic> body = {
    //       'amount': calculateAmount(amount),
    //       'currency': currency,
    //     };

    //     //Make post request to Stripe
    //     var response = await http.post(
    //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
    //       headers: {
    //         'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
    //         'Content-Type': 'application/x-www-form-urlencoded'
    //       },
    //       body: body,
    //     );
    //     return json.decode(response.body);
    //   } catch (err) {
    //     throw Exception(err.toString());
    //   }
    // }

    // calculateAmount(String amount) {
    //   final calculatedAmout = (int.parse(amount)) * 100;
    //   return calculatedAmout.toString();
    // }}}}
  }
}
