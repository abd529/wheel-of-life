// ignore_for_file: must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously, avoid_unnecessary_containers, library_prefixes, avoid_print

import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:com.ezeelogix.truenorth/Screens/wheel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:graphic/graphic.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

import '../Utilities/popup_loader.dart';


class PDFScreen extends StatefulWidget {
  final String userId;
  final int baseQ1 ;
  final int baseQ2 ;
  final int baseQ3 ;
  final int baseQ4 ;
  final int baseQ5 ;
  final int baseQ6 ;
  final int baseQ7 ;
  final int baseQ8 ;
  final int healthQ1 ;
  final int healthQ2 ;
  final int healthQ3 ;
  final int healthQ4 ;
  final int healthQ5 ;
  final int healthQ6 ;
  final double healthAvg ;

  final int personalQ1 ;
  final int personalQ2 ;
  final int personalQ3 ;
  final int personalQ4 ;
  final int personalQ5 ;
  final int personalQ6 ;
  final int personalQ7 ;
  final int personalQ8 ;
  final double personalAvg ;

  final int homeQ1 ;
  final int homeQ2 ;
  final int homeQ3 ;
  final int homeQ4 ;
  final int homeQ5 ;
  final int homeQ6 ;
  final double homeAvg ;

  final int famQ1 ;
  final int famQ2 ;
  final int famQ3 ;
  final int famQ4 ;
  final int famQ5 ;
  final int famQ6 ;
  final int famQ7 ;
  final double famAvg ;

  final int loveQ1 ;
  final int loveQ2 ;
  final int loveQ3 ;
  final int loveQ4 ;
  final int loveQ5 ;
  final int loveQ6 ;
  final int loveQ7 ;
  final int loveQ8 ;
  final double loveAvg ;

  final int freeQ1 ;
  final int freeQ2 ;
  final int freeQ3 ;
  final int freeQ4 ;
  final int freeQ5 ;
  final int freeQ6 ;
  final double freeAvg ;

  final int workQ1 ;
  final int workQ2 ;
  final int workQ3 ;
  final int workQ4 ;
  final int workQ5 ;
  final int workQ6 ;
  final int workQ7 ;
  final int workQ8 ;
  final double workAvg ;

  final int moneyQ1 ;
  final int moneyQ2 ;
  final int moneyQ3 ;
  final int moneyQ4 ;
  final int moneyQ5 ;
  final int moneyQ6 ;
  final int moneyQ7 ;
  final int moneyQ8 ;
  final double moneyAvg;
  const PDFScreen({super.key, required this.userId, required this.baseQ1, required this.baseQ2, required this.baseQ3, required this.baseQ4, required this.baseQ5, required this.baseQ6, required this.baseQ7, required this.baseQ8, required this.healthQ1, required this.healthQ2, required this.healthQ3, required this.healthQ4, required this.healthQ5, required this.healthQ6, required this.personalQ1, required this.personalQ2, required this.personalQ3, required this.personalQ4, required this.personalQ5, required this.personalQ6, required this.personalQ7, required this.personalQ8, required this.homeQ1, required this.homeQ2, required this.homeQ3, required this.homeQ4, required this.homeQ5, required this.homeQ6, required this.famQ1, required this.famQ2, required this.famQ3, required this.famQ4, required this.famQ5, required this.famQ6, required this.famQ7, required this.loveQ1, required this.loveQ2, required this.loveQ3, required this.loveQ4, required this.loveQ5, required this.loveQ6, required this.loveQ7, required this.loveQ8, required this.freeQ1, required this.freeQ2, required this.freeQ3, required this.freeQ4, required this.freeQ5, required this.freeQ6, required this.workQ1, required this.workQ2, required this.workQ3, required this.workQ4, required this.workQ5, required this.workQ6, required this.workQ7, required this.workQ8, required this.moneyQ1, required this.moneyQ2, required this.moneyQ3, required this.moneyQ4, required this.moneyQ5, required this.moneyQ6, required this.moneyQ7, required this.moneyQ8, required this.healthAvg, required this.personalAvg, required this.homeAvg, required this.famAvg, required this.loveAvg, required this.freeAvg, required this.workAvg, required this.moneyAvg});
  
  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final GlobalKey _globalKey = GlobalKey();
  double baseAvg =0.0;

  List topics = const ['Topic 1', 'Topic 2', 'Topic 3'];

  List questions = const [
    'Question 1',
    'Question 2',
    'Question 3'
  ]; 
 // Replace with your questions
  List answers = const ['Answer 1', 'Answer 2', 'Answer 3'];
  
  Future<Uint8List> getImageBytesFromAsset(String assetPath) async {
  ByteData data = await rootBundle.load(assetPath);
  return data.buffer.asUint8List();
}
  Future<Uint8List> getImageBytesFromRepaintBoundary(GlobalKey boundaryKey) async {
  try {
    RenderRepaintBoundary boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 1.0);
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  } catch (error) {
    print("Error capturing image from RepaintBoundary: $error");
    return Uint8List(0); // Return an empty Uint8List on error
  }
}

  Future<void> createPdf(String uid,BuildContext ctx) async {
    Uint8List logoBytes = await getImageBytesFromAsset("assets/logo.png");
    Uint8List graphBytes = await getImageBytesFromRepaintBoundary(_globalKey);
    PopupLoader.show();
    Size size = MediaQuery.of(context).size;
    final pdf = pdfWidgets.Document();
    pdf.addPage(pdfWidgets.MultiPage(
        build: (context) => [
              pdfWidgets.Padding(
                padding: const pdfWidgets.EdgeInsets.all(8.0),
                child: pdfWidgets.SizedBox(
                    width: double.infinity,
                    child: pdfWidgets.Column(
                        mainAxisAlignment: pdfWidgets.MainAxisAlignment.start,
                        children: [
                          // ElevatedButton(onPressed: (){createPdf();}, child: const Text("Generate PDF")),
                          // ElevatedButton(onPressed: (){}, child: const Text("Save to Cloud Storage")),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.center,
                            children: [
                              pdfWidgets.Image(
                                pdfWidgets.MemoryImage(logoBytes),
                                width: 85,
                                height: 85,
                              ),
                              pdfWidgets.SizedBox(
                                width: 20,
                              ),
                              pdfWidgets.Column(
                                children: [
                                  pdfWidgets.Text(
                                    "True North",
                                    style: const pdfWidgets.TextStyle(
                                        fontSize: 24),
                                  ),
                                  pdfWidgets.Text("Inspired by Wheel of Life")
                                ],
                              ),
                            ],
                          ),
                          pdfWidgets.Divider(
                            thickness: 2,
                          ),
                          // pdfWidgets.SizedBox(
                          //   height: 20,
                          // ),
                          // pdfWidgets.Row(
                          //   children: [
                          //     pdfWidgets.Text(
                          //       "Name: ",
                          //       style: pdfWidgets.TextStyle(
                          //           fontSize: 14,
                          //           fontWeight: pdfWidgets.FontWeight.bold),
                          //     ),
                          //     pdfWidgets.Text(name),
                          //   ],
                          // ),
                          // pdfWidgets.SizedBox(
                          //   height: 30,
                          // ),
                          // pdfWidgets.Column(
                          //   children: [
                          //     pdfWidgets.Row(
                          //       children: [
                          //         pdfWidgets.Text(
                          //           "Coach: ",
                          //           style: pdfWidgets.TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: pdfWidgets.FontWeight.bold),
                          //         ),
                          //         pdfWidgets.Text("Atif Pervaiz"),
                          //       ],
                          //     ),
                          //     pdfWidgets.Row(
                          //       children: [
                          //         pdfWidgets.Text(
                          //           "Email: ",
                          //           style: pdfWidgets.TextStyle(
                          //               fontSize: 14,
                          //               fontWeight: pdfWidgets.FontWeight.bold),
                          //         ),
                          //         pdfWidgets.Text(
                          //           "atif123@gmail.com",
                          //           softWrap: true,
                          //         ),
                          //       ],
                          //     )
                          //   ],
                          // ),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.basedOnAnswers,
                          ),
                          pdfWidgets.SizedBox(
                            height: 30,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.comfortableWithHealth,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ1.toString()),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.doneWithWhatIWant,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ2.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.liveWhereIWant,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ3.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.familyAndFriendsFillLife,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ4.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.liveInHarmonyAndPeace,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ5.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.takeFreeSpaces,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ6.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.takeFreeSpaces,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ7.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.SizedBox(
                                  width: size.width - 50,
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.administerMoneyWell,
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text(widget.baseQ8.toString(),),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Container(
                              child: pdfWidgets.Text(
                                  AppLocalizations.of(ctx)!.liveWhereIWant,
                                   )),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.health,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Mood",
                              //   style: const pdfWidgets.TextStyle(),
                              // ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.healthQone,
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Psychological state",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.healthQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Personal care",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.healthQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Physical state",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.healthQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Habits",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.healthQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),

                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Measures",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.healthQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.healthQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.personalG,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Society",
                              //   style: const pdfWidgets.TextStyle(),
                              // ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQone,
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Current Projects",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Future projects",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Spirituality",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Self-esteem",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Attitudes",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Skills",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQseven,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ7.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Studies",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.personalQeight,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.personalQ8.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.home,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Country",
                              //   style: const pdfWidgets.TextStyle(),
                              // ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQone,
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.homeQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "City",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.homeQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "District",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  AppLocalizations.of(ctx)!.homeQtwo,
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Home",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.homeQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Coexistence",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  AppLocalizations.of(ctx)!.homeQtwo,
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Home care",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.homeQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.homeQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.famFriends,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Provision",
                              //   style: const pdfWidgets.TextStyle(),
                              // ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQone,
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Mother",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Father",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Children",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Close Relatives",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),

                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Friends",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Known",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.famQseven,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.famQ7.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.love,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Ability to love",
                              //   style: const pdfWidgets.TextStyle(),
                              // ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.loveQone,
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Number of relationships",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Duration",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Communication",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Coexistence",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      AppLocalizations.of(ctx)!.loveQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Fidelity",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Sexual passion",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQseven,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ7.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Emotional Passion",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.loveQeight,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ8.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.freeTime,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Leisure",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQone,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.freeQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Quality Time",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.freeQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Fun",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.freeQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),

                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Variety",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.loveQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Tastes",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.freeQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Participatory",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.freeQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.freeQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.work,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Working Capacity",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQone,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Functions",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Company",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Boss",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Companions",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Collabrators",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Recognition",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.workQseven,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.workQ7.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.Text(
                            AppLocalizations.of(ctx)!.money,
                            style: pdfWidgets.TextStyle(
                                fontWeight: pdfWidgets.FontWeight.bold,
                                fontSize: 20),
                          ),
                          pdfWidgets.SizedBox(
                            height: 10,
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.Text(
                              //   "Section",
                              //   style: pdfWidgets.TextStyle(
                              //       fontWeight: pdfWidgets.FontWeight.bold),
                              // ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.question,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                AppLocalizations.of(ctx)!.answer,
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Belongings",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQone,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ1.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Gurantees",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQtwo,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ2.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Income",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQthree,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ3.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Future Income",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQfour,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ4.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Bills",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQfive,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ5.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Future expenses",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQsix,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ6.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Debts",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQseven,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ7.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 10),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              // pdfWidgets.SizedBox(
                              //     width: 100,
                              //     child: pdfWidgets.Text(
                              //       "Saving",
                              //       style: const pdfWidgets.TextStyle(),
                              //     )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                    AppLocalizations.of(ctx)!.moneyQeight,
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  widget.moneyQ8.toString(),
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(height: 20),
                          pdfWidgets.SizedBox(height: 400),
                          pdfWidgets.Text(AppLocalizations.of(ctx)!.yourWheelOfLife, style: pdfWidgets.TextStyle(fontSize: 20, fontWeight: pdfWidgets.FontWeight.bold)),
                          pdfWidgets.SizedBox(height: 5),
                          pdfWidgets.Row(
                            mainAxisAlignment: pdfWidgets.MainAxisAlignment.spaceEvenly,
                            children: [
                            pdfWidgets.Text(AppLocalizations.of(ctx)!.blueForBaseline),
                            pdfWidgets.Text(AppLocalizations.of(ctx)!.greenForResults)
                            ]
                          ),
                          pdfWidgets.Image(
                                pdfWidgets.MemoryImage(graphBytes),
                                width: 400,
                                height: 300,
                              ),
                        ])),
              ),
            ]));
    final pdfBytes = await pdf.save();
    uploadPdfToFirebaseStorage(uid, pdfBytes);
    // Save pdfBytes to Firebase Cloud Storage
    
  }

  Future<void> uploadPdfToFirebaseStorage(
      String fileName, List<int> pdfBytes) async {
    final ref = FirebaseStorage.instance.ref().child(fileName);
    await ref.putData(Uint8List.fromList(pdfBytes));
    String downloadUrl = await ref.getDownloadURL();
    print("linkkk $downloadUrl");
    PopupLoader.hide();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final adjustData = [
                        {"type": "BaseLine", "index": "Health", "value": widget.baseQ1},
                        {"type": "BaseLine", "index": "Personal Growth", "value": widget.baseQ2},
                        {"type": "BaseLine", "index": "Home", "value": widget.baseQ3},
                        {"type": "BaseLine", "index": "Family & Friends", "value": widget.baseQ4},
                        {"type": "BaseLine", "index": "Love", "value": widget.baseQ5},
                        {"type": "BaseLine", "index": "Free Time", "value": widget.baseQ6},
                        {"type": "BaseLine", "index": "Work", "value": widget.baseQ7},
                        {"type": "BaseLine", "index": "Money", "value": widget.baseQ8},
                
                        {"type": "Results", "index": "Health", "value": widget.healthAvg.toInt()},
                        {"type": "Results", "index": "Personal Growth", "value": widget.personalAvg.toInt()},
                        {"type": "Results", "index": "Home", "value": widget.homeAvg.toInt()},
                        {"type": "Results", "index": "Family & Friends", "value": widget.famAvg.toInt()},
                        {"type": "Results", "index": "Love", "value": widget.loveAvg.toInt()},
                        {"type": "Results", "index": "Free Time", "value": widget.freeAvg.toInt()},
                        {"type": "Results", "index": "Work", "value": widget.workAvg.toInt()},
                        {"type": "Results", "index": "Money", "value": widget.moneyAvg.toInt()},
                ];
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                // ElevatedButton(
                //     onPressed: () {
                //       createPdf(userId,context);
                //     },
                //     child: const Text("Generate PDF")),
                // ElevatedButton(
                //     onPressed: () {},
                //     child: const Text("Save to Cloud Storage")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 85,
                      height: 85,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Text(
                          "True North",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text("Inspired by Wheel of Life")
                      ],
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Row(
                //   children: [
                //     Text(
                //       "Name: ",
                //       style:
                //           TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                //     ),
                //     Text("Abdullah Ayaz"),
                //   ],
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // const Column(
                //   children: [
                //     Row(
                //       children: [
                //         Text(
                //           "Coach: ",
                //           style: TextStyle(
                //               fontSize: 14, fontWeight: FontWeight.bold),
                //         ),
                //         Text("Atif Pervaiz"),
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Text(
                //           "Email: ",
                //           style: TextStyle(
                //               fontSize: 14, fontWeight: FontWeight.bold),
                //         ),
                //         Text(
                //           "atif123@gmail.com",
                //           softWrap: true,
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    AppLocalizations.of(context)!.basedOnAnswers),
                const SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(
                            AppLocalizations.of(context)!.comfortableWithHealth ,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Text(widget.baseQ1.toString())
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(AppLocalizations.of(context)!.doneWithWhatIWant,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ2.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text( AppLocalizations.of(context)!.liveWhereIWant ,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ3.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child:  Text(AppLocalizations.of(context)!.familyAndFriendsFillLife,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ4.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(AppLocalizations.of(context)!.liveInHarmonyAndPeace,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ5.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(AppLocalizations.of(context)!.takeFreeSpaces,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ6.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(AppLocalizations.of(context)!.professionallySatisfied,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ7.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: Text(AppLocalizations.of(context)!.administerMoneyWell,
                            softWrap: true,
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(widget.baseQ8.toString())
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: Text(
                        AppLocalizations.of(context)!.afterBaselineIntro)),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.health,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Mood",
                  AppLocalizations.of(context)!.healthQone,
                  widget.healthQ1.toString()
                  ),
                tableRow(context,
                  "Psychological state",
                  AppLocalizations.of(context)!.healthQtwo,
                  widget.healthQ2.toString()
                  ),
                tableRow(context,
                  "Personal care",
                  AppLocalizations.of(context)!.healthQthree,
                  widget.healthQ3.toString()
                  ),
                tableRow(context,
                  "Physical state",
                  AppLocalizations.of(context)!.healthQfour,
                  widget.healthQ4.toString()
                  ),
                tableRow(context,
                  "Habits",
                  AppLocalizations.of(context)!.healthQfive,
                  widget.healthQ5.toString()
                  ),
                tableRow(context,
                  "Measures",
                  AppLocalizations.of(context)!.healthQsix,
                  widget.healthQ6.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.healthAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.personalG,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Society",
                  AppLocalizations.of(context)!.personalQone,
                  widget.personalQ1.toString()
                  ),
                tableRow(context,
                  "Current projects",
                  AppLocalizations.of(context)!.personalQtwo,
                  widget.personalQ2.toString()
                  ),
                tableRow(context,
                  "Future projects",
                  AppLocalizations.of(context)!.personalQthree,
                  widget.personalQ3.toString()
                  ),
                tableRow(context,
                  "Spirituality",
                  AppLocalizations.of(context)!.personalQfour,
                  widget.personalQ4.toString()
                  ),
                tableRow(context,
                  "Self-esteem",
                  AppLocalizations.of(context)!.personalQfive,
                  widget.personalQ5.toString()
                  ),
                tableRow(context,
                  "Attitudes",
                  AppLocalizations.of(context)!.personalQsix,
                  widget.personalQ6.toString()
                  ),
                  tableRow(context,
                  "Skills",
                  AppLocalizations.of(context)!.personalQseven,
                  widget.personalQ7.toString()
                  ), 
                  tableRow(context,
                  "Studies",
                  AppLocalizations.of(context)!.personalQeight,
                  widget.personalQ8.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.personalAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.home,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Country",
                  AppLocalizations.of(context)!.homeQone,
                  widget.homeQ1.toString()
                  ),
                tableRow(context,
                  "City",
                  AppLocalizations.of(context)!.homeQtwo,
                  widget.homeQ2.toString()
                  ),
                tableRow(context,
                  "District",
                  AppLocalizations.of(context)!.homeQthree,
                  widget.homeQ3.toString()
                  ),
                tableRow(context,
                  "Home",
                  AppLocalizations.of(context)!.homeQfour,
                  widget.homeQ4.toString()
                  ),
                tableRow(context,
                  "Coexistence",
                  AppLocalizations.of(context)!.homeQfive,
                  widget.homeQ5.toString()
                  ),
                tableRow(context,
                  "Home care",
                  AppLocalizations.of(context)!.homeQsix,
                  widget.homeQ6.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.homeAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.famFriends,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Provision",
                  AppLocalizations.of(context)!.famQone,
                  widget.famQ1.toString()
                  ),
                tableRow(context,
                  "Mother",
                  AppLocalizations.of(context)!.famQtwo,
                  widget.famQ2.toString()
                  ),
                tableRow(context,
                  "Father",
                  AppLocalizations.of(context)!.famQthree,
                  widget.famQ3.toString()
                  ),
                tableRow(context,
                  "Children",
                  AppLocalizations.of(context)!.famQfour,
                  widget.famQ4.toString()
                  ),
                tableRow(context,
                  "Close relatives",
                  AppLocalizations.of(context)!.famQfive,
                  widget.famQ5.toString()
                  ),
                tableRow(context,
                  "Friends",
                  AppLocalizations.of(context)!.famQsix,
                  widget.famQ6.toString()
                  ),
                  tableRow(context,
                  "Known",
                  AppLocalizations.of(context)!.famQseven,
                  widget.famQ7.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.famAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.love,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Ability \nto love",
                  AppLocalizations.of(context)!.loveQone,
                  widget.loveQ1.toString()
                  ),
                tableRow(context,
                  "Number \nof \nrelationships",
                  AppLocalizations.of(context)!.loveQtwo,
                  widget.loveQ2.toString()
                  ),
                tableRow(context,
                  "Duration",
                  AppLocalizations.of(context)!.loveQthree,
                  widget.loveQ3.toString()
                  ),
                tableRow(context,
                  "Communication",
                  AppLocalizations.of(context)!.loveQfour,
                  widget.loveQ4.toString()
                  ),
                tableRow(context,
                  "Coexistence",
                  AppLocalizations.of(context)!.loveQfive,
                  widget.loveQ5.toString()
                  ),
                tableRow(context,
                  "Fidelity",
                  AppLocalizations.of(context)!.loveQsix,
                  widget.loveQ6.toString()
                  ),
                  tableRow(context,
                  "Sexual passion",
                  AppLocalizations.of(context)!.loveQseven,
                  widget.loveQ7.toString()
                  ), 
                  tableRow(context,
                  "Emotional Passion",
                  AppLocalizations.of(context)!.loveQeight,
                  widget.loveQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.loveAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                  Text(
                  AppLocalizations.of(context)!.freeTime,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Leisure",
                  AppLocalizations.of(context)!.freeQone,
                  widget.freeQ1.toString()
                  ),
                tableRow(context,
                  "Quality time",
                  AppLocalizations.of(context)!.freeQtwo,
                  widget.freeQ2.toString()
                  ),
                tableRow(context,
                  "Fun",
                  AppLocalizations.of(context)!.freeQthree,
                  widget.freeQ3.toString()
                  ),
                tableRow(context,
                  "Variety",
                  AppLocalizations.of(context)!.freeQfour,
                  widget.freeQ4.toString()
                  ),
                tableRow(context,
                  "Tastes",
                  AppLocalizations.of(context)!.freeQfive,
                  widget.freeQ5.toString()
                  ),
                tableRow(context,
                  "Participatory",
                  AppLocalizations.of(context)!.freeQsix,
                  widget.freeQ6.toString()
                  ),
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.freeAvg.toStringAsFixed(1),
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    Text(
                  AppLocalizations.of(context)!.work,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Working capacity",
                  AppLocalizations.of(context)!.workQone,
                  widget.workQ1.toString()
                  ),
                tableRow(context,
                  "Functions",
                  AppLocalizations.of(context)!.workQtwo,
                  widget.workQ2.toString()
                  ),
                tableRow(context,
                  "Company",
                  AppLocalizations.of(context)!.workQthree,
                  widget.workQ3.toString()
                  ),
                tableRow(context,
                  "Boss",
                  AppLocalizations.of(context)!.workQfour,
                  widget.workQ4.toString()
                  ),
                tableRow(context,
                  "Companions",
                  AppLocalizations.of(context)!.workQfive,
                  widget.workQ5.toString()
                  ),
                tableRow(context,
                  "Collaborators",
                  AppLocalizations.of(context)!.workQsix,
                  widget.workQ6.toString()
                  ),
                  tableRow(context,
                  "Recognition",
                  AppLocalizations.of(context)!.workQseven,
                  widget.workQ7.toString()
                  ), 
                  tableRow(context,
                  "Remuneration",
                  AppLocalizations.of(context)!.workQeight,
                  widget.workQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.workAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                  Text(
                  AppLocalizations.of(context)!.money,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Section",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    Text(
                      AppLocalizations.of(context)!.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                     AppLocalizations.of(context)!.answer,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(context,
                  "Belongings",
                  AppLocalizations.of(context)!.moneyQone,
                  widget.moneyQ1.toString()
                  ),
                tableRow(context,
                  "Guarantees",
                  AppLocalizations.of(context)!.moneyQtwo,
                  widget.moneyQ2.toString()
                  ),
                tableRow(context,
                  "Income",
                  AppLocalizations.of(context)!.moneyQthree,
                  widget.moneyQ3.toString()
                  ),
                tableRow(context,
                  "Future income",
                  AppLocalizations.of(context)!.moneyQfour,
                  widget.moneyQ4.toString()
                  ),
                tableRow(context,
                  "Bills",
                  AppLocalizations.of(context)!.moneyQfive,
                  widget.moneyQ5.toString()
                  ),
                tableRow(context,
                  "Future expenses",
                  AppLocalizations.of(context)!.moneyQsix,
                  widget.moneyQ6.toString()
                  ),
                  tableRow(context,
                  "Debts",
                  AppLocalizations.of(context)!.moneyQseven,
                  widget.moneyQ7.toString()
                  ), 
                  tableRow(context,
                  "Saving",
                  AppLocalizations.of(context)!.moneyQeight,
                  widget.moneyQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(context,
                  "Average",
                  AppLocalizations.of(context)!.avg,
                  widget.moneyAvg.toStringAsFixed(1)
                  ),
                  ],
                ),
                Padding(
          padding: const EdgeInsets.all(05),
          child: SizedBox(
            width: 400,
                  height: 300,
            child: Stack(
              children: [
                Blur(
                  blur: 1,
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: size.width - 30,
                          height: 300,
                          color: Colors.white,
                          child: Chart(
                            data: adjustData,
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
                                accessor: (Map map) =>
                                    map['value'] as num,
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
                              //Defaults.radialAxis,
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
                Image.asset("assets/dummy_graph.jpg", height: 300,width: 400,),
                Center(
                              child: Text(
                            AppLocalizations.of(context)!.sampleWheelText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
              ],
            ),
          ),
        ),
                Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(onPressed: () async {
                  await createPdf(widget.userId, context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WheelOfLife( 
                                          userId: widget.userId ,
                                          adjustData: [
                        {"type": "BaseLine", "index": "Health", "value": widget.baseQ1},
                        {"type": "BaseLine", "index": "Personal Growth", "value": widget.baseQ2},
                        {"type": "BaseLine", "index": "Home", "value": widget.baseQ3},
                        {"type": "BaseLine", "index": "Family & Friends", "value": widget.baseQ4},
                        {"type": "BaseLine", "index": "Love", "value": widget.baseQ5},
                        {"type": "BaseLine", "index": "Free Time", "value": widget.baseQ6},
                        {"type": "BaseLine", "index": "Work", "value": widget.baseQ7},
                        {"type": "BaseLine", "index": "Money", "value": widget.baseQ8},
                
                        {"type": "Results", "index": "Health", "value": widget.healthAvg.toInt()},
                        {"type": "Results", "index": "Personal Growth", "value": widget.personalAvg.toInt()},
                        {"type": "Results", "index": "Home", "value": widget.homeAvg.toInt()},
                        {"type": "Results", "index": "Family & Friends", "value": widget.famAvg.toInt()},
                        {"type": "Results", "index": "Love", "value": widget.loveAvg.toInt()},
                        {"type": "Results", "index": "Free Time", "value": widget.freeAvg.toInt()},
                        {"type": "Results", "index": "Work", "value": widget.workAvg.toInt()},
                        {"type": "Results", "index": "Money", "value": widget.moneyAvg.toInt()},
                ]),
                                        ));
                                  }, 
                                  style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(size.width/4, size.height/40, size.width/4, size.height/40),
                          shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(50)
                              ),),
                                  child: Text(AppLocalizations.of(context)!.sendEmail, textAlign: TextAlign.center,)),
              ),
              Text(AppLocalizations.of(context)!.getDetailedReport, textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.bold))
                //     CustomTable(
                // // Replace with your topic names
                // // Replace with your answers
                //     ),
              ])),
        ),
      ),
    ));
  }

  Row tableRow(BuildContext context, String section, String question, String answer) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  // section  ,
                  //   style: const TextStyle(),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-60,
                    child: Text(
                    question,
                    style: const TextStyle(),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      answer,
                      style: const TextStyle(),
                    ),
                  ),
                ],
              );
  }
}
