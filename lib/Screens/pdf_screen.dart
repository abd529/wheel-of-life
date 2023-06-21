// ignore_for_file: must_be_immutable

import 'dart:typed_data';
import 'package:com.ezeelogix.truenorth/Screens/wheel.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;


class PDFScreen extends StatelessWidget {
  final String name = "abd";
  final String userId;
  final int baseQ1 ;
  final int baseQ2 ;
  final int baseQ3 ;
  final int baseQ4 ;
  final int baseQ5 ;
  final int baseQ6 ;
  final int baseQ7 ;
  final int baseQ8 ;
  double baseAvg =0.0;

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
  PDFScreen({super.key, required this.userId, required this.baseQ1, required this.baseQ2, required this.baseQ3, required this.baseQ4, required this.baseQ5, required this.baseQ6, required this.baseQ7, required this.baseQ8, required this.healthQ1, required this.healthQ2, required this.healthQ3, required this.healthQ4, required this.healthQ5, required this.healthQ6, required this.personalQ1, required this.personalQ2, required this.personalQ3, required this.personalQ4, required this.personalQ5, required this.personalQ6, required this.personalQ7, required this.personalQ8, required this.homeQ1, required this.homeQ2, required this.homeQ3, required this.homeQ4, required this.homeQ5, required this.homeQ6, required this.famQ1, required this.famQ2, required this.famQ3, required this.famQ4, required this.famQ5, required this.famQ6, required this.famQ7, required this.loveQ1, required this.loveQ2, required this.loveQ3, required this.loveQ4, required this.loveQ5, required this.loveQ6, required this.loveQ7, required this.loveQ8, required this.freeQ1, required this.freeQ2, required this.freeQ3, required this.freeQ4, required this.freeQ5, required this.freeQ6, required this.workQ1, required this.workQ2, required this.workQ3, required this.workQ4, required this.workQ5, required this.workQ6, required this.workQ7, required this.workQ8, required this.moneyQ1, required this.moneyQ2, required this.moneyQ3, required this.moneyQ4, required this.moneyQ5, required this.moneyQ6, required this.moneyQ7, required this.moneyQ8, required this.healthAvg, required this.personalAvg, required this.homeAvg, required this.famAvg, required this.loveAvg, required this.freeAvg, required this.workAvg, required this.moneyAvg});
  
  List topics = const ['Topic 1', 'Topic 2', 'Topic 3'];
  List questions = const [
    'Question 1',
    'Question 2',
    'Question 3'
  ]; // Replace with your questions
  List answers = const ['Answer 1', 'Answer 2', 'Answer 3'];

  Future<void> createPdf(String uid,BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    // Future<Uint8List> pdfImage()async{
    final ByteData bytes = await rootBundle.load('assets/logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    //   return byteList;
    // }

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
                                pdfWidgets.MemoryImage(byteList),
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
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Row(
                            children: [
                              pdfWidgets.Text(
                                "Name: ",
                                style: pdfWidgets.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(name),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 30,
                          ),
                          pdfWidgets.Column(
                            children: [
                              pdfWidgets.Row(
                                children: [
                                  pdfWidgets.Text(
                                    "Coach: ",
                                    style: pdfWidgets.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pdfWidgets.FontWeight.bold),
                                  ),
                                  pdfWidgets.Text("Atif Pervaiz"),
                                ],
                              ),
                              pdfWidgets.Row(
                                children: [
                                  pdfWidgets.Text(
                                    "Email: ",
                                    style: pdfWidgets.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pdfWidgets.FontWeight.bold),
                                  ),
                                  pdfWidgets.Text(
                                    "atif123@gmail.com",
                                    softWrap: true,
                                  ),
                                ],
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Text(
                              "Based on the answers to the question, this is what you believe your current situation is:"),
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
                                      "I am comfortable with my physical and mental health.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "I live in the place I want.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "My family and friends fill my life.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "I live in harmony and peace.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "I take my free spaces.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "I am professionally satisfied.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "Administer well the money I have.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
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
                                      "I am comfortable with my physical and mental health.",
                                      softWrap: true,
                                      style: pdfWidgets.TextStyle(
                                          fontWeight:
                                              pdfWidgets.FontWeight.bold))),
                              pdfWidgets.Container(
                                child: pdfWidgets.Text("5"),
                              )
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Container(
                              child: pdfWidgets.Text(
                                  "After the baseline, you have answered many questions in each section to help you determine where you actually are in your life. These are the answers, by section, are shown in the following pages.")),
                          pdfWidgets.SizedBox(
                            height: 20,
                          ),
                          pdfWidgets.Text(
                            "Health",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.Text(
                                "Mood",
                                style: const pdfWidgets.TextStyle(),
                              ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                "Is there anything that alters my psychological state?",
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "1",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Psychological state",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I carry out activities that move me away from a state of tension, nerves, stress, etc.?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Personal care",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "When I am discouraged, I adopt measures that allow me to recover it adequately and quickly?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Physical state",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I have any disease that affects my physical state?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Habits",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "The resting time, food, sport and more, are they adequate?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Measures",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "If I lose my physical condition, do I adopt measures that allow me to recover it satisfactorily?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            "Personal Growth",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.Text(
                                "Society",
                                style: const pdfWidgets.TextStyle(),
                              ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                "Do I feel useful to society, do I contribute to the development of my society?",
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "1",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Current Projects",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I comfortable with my personal growth plans and projects?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Future projects",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do my projects to futures satisfy the perspectives I have to grow?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Spirituality",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel good with my spirituality and cultivation constantly?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Self-esteem",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I give true value to my life and my affections?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Attitudes",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I face life in a planned, applied manner and have a will to improve?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Skills",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How many skills can I say that I have to do everything that I propose?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Studies",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with my professional training and I try to move forward?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            "Home",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.Text(
                                "Country",
                                style: const pdfWidgets.TextStyle(),
                              ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                "Am I satisfied in the country in which I live, according to the current policy, social and cultural environment where I live?",
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "1",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "City",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel comfortable in the city in which I live and agree with the services it offers?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "District",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I like my neighbors and their culture of coexistence?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Home",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "The house where I live satisfies me, has enough space and comfort that I need?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Coexistence",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I comfortable with the people with whom I share my home?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Home care",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How satisfied am I with the degree of comfort, cleanliness and care that I believe in my home?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            "Family & Friends",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.Text(
                                "Provision",
                                style: const pdfWidgets.TextStyle(),
                              ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                "Do I feel satisfied with the ability I have to find and communicate with new friends or family?",
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "1",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Mother",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the relationship I have with my mother?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Father",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the relationship I have with my father?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Children",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the relationship I have with my children? If I don't have them and I love them, do I do actions to have them?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Close Relatives",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How do I feel in my relationships with close relatives: brothers, grandparents, cousins, uncles, etc.?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Friends",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "I feel satisfied with the friends I have, do I really have them when I need them and support me?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Known",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I comfortable with the acquaintances I have?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            "Love",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                            ],
                          ),
                          pdfWidgets.Row(
                            mainAxisAlignment:
                                pdfWidgets.MainAxisAlignment.spaceBetween,
                            children: [
                              pdfWidgets.Text(
                                "Ability to love",
                                style: const pdfWidgets.TextStyle(),
                              ),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                "May I give myself to my relationships?",
                                style: const pdfWidgets.TextStyle(),
                                softWrap: true,
                                textAlign: pdfWidgets.TextAlign.center,
                              )),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "1",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Number of relationships",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the number of sentimental relationships that I have, or I would like to have other additional relationships?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Duration",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I happy with the time that my relationships last, I do things to keep my partner and give it stability?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Communication",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I understand my partner well, and I am satisfied with the communication and coexistence I have?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Coexistence",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do we distribute home tasks?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Fidelity",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I faithful in my relationships, and I have the confidence that my partner is the same?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Sexual passion",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I have sexual relations with my partner and it attracts me physically?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Emotional Passion",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel really loved and positively value all the mental and emotional part of my partner?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.SizedBox(
                            height: 50,
                          ),
                          pdfWidgets.Text(
                            "Free Time",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Leisure",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I have enough leisure time, or do I think it should have more?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Quality Time",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel that I take advantage of the time I have and take advantage of my leisure?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Fun",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "May I have enough in my leisure times or do I feel bored, and I don't enjoy it?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Variety",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "What other activities do, such as reading, cinema, TV, shows, see photos, study, etc.?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Tastes",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied doing a sport, practicing a hobby such as playing video games, etc.?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Participatory",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How do I value the leisure in which I participate with other people, such as a meeting with friends, family, games, etc.?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.Text(
                            "Work",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Working Capacity",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "I feel satisfied with my performance in the work environment and I really want to work on what I do?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Functions",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the functions I perform, and I am developing tasks that generate value in the company?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Company",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel comfortable in my company and she respects my values?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Boss",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with my boss or me in my role as a boss?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Companions",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel that we form a good team with my teammates?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Collabrators",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I feel satisfied with the work of my collaborators and we form a good team?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Recognition",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I recognized in my work, I feel that the work I do is valued?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),
                          pdfWidgets.Text(
                            "Money",
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
                              pdfWidgets.Text(
                                "Section",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Question",
                                style: pdfWidgets.TextStyle(
                                    fontWeight: pdfWidgets.FontWeight.bold),
                              ),
                              pdfWidgets.Text(
                                "Answere",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Belongings",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How do I feel about the belongings I have? Can I satisfy everything I have?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Gurantees",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I have guarantees that support me financially and I feel sufficient guarantees?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Income",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the income I have today and are enough to have the standard of living?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Future Income",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the income I will have in the future, and my perspective of economic growth is promising?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Bills",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "How do I feel about the level of expenses I have. Expenditure above my possibilities?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Future expenses",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Do I anticipate many expenses in the future and I feel that I will not be able to cover my future accounts?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Debts",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Am I satisfied with the level of debts I have? Or do I feel very overwhelmed with economic commitments?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
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
                              pdfWidgets.SizedBox(
                                  width: 100,
                                  child: pdfWidgets.Text(
                                    "Saving",
                                    style: const pdfWidgets.TextStyle(),
                                  )),
                              pdfWidgets.Expanded(
                                  child: pdfWidgets.Text(
                                      "Keep some money for bad times, and I'm happy with my savings?",
                                      style: const pdfWidgets.TextStyle(),
                                      softWrap: true,
                                      textAlign: pdfWidgets.TextAlign.center)),
                              pdfWidgets.Padding(
                                padding: const pdfWidgets.EdgeInsets.all(4.0),
                                child: pdfWidgets.Text(
                                  "2",
                                  style: const pdfWidgets.TextStyle(),
                                ),
                              ),
                            ],
                          ),

                          //     pdfWidgets.CustomTable(
                          // topics: const ['Topic 1', 'Topic 2', 'Topic 3'], // Replace with your topic names
                          // questions: const ['Question 1', 'Question 2', 'Question 3'], // Replace with your questions
                          // answers: const ['Answer 1', 'Answer 2', 'Answer 3'], // Replace with your answers
                          //     ),
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
    // PDF file is now saved to Firebase Cloud Storage
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                const Text(
                    "Based on the answers to the question, this is what you believe your current situation is:"),
                const SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text(
                            "I am comfortable with my physical and mental health.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Text(baseQ1.toString())
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("I live in the place I want.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ2.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("My family and friends fill my life.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ3.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("I live in harmony and peace.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ4.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("I take my free spaces.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ5.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("I am professionally satisfied.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ6.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text("Administer well the money I have.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ7.toString())
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width - 60,
                        child: const Text(
                            "I am comfortable with my physical and mental health.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: Text(baseQ8.toString())
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    child: const Text(
                        "After the baseline, you have answered many questions in each section to help you determine where you actually are in your life. These are the answers, by section, are shown in the following pages.")),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                  "Health",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Mood",
                  "Is there anything that alters my psychological state?",
                  healthQ1.toString()
                  ),
                tableRow(
                  "Psychological state",
                  "Do I carry out activities that move me away from a state of tension, nerves, stress, etc.?",
                  healthQ2.toString()
                  ),
                tableRow(
                  "Personal care",
                  "When I am discouraged, I adopt measures that allow me to recover it adequately and quickly?",
                  healthQ3.toString()
                  ),
                tableRow(
                  "Physical state",
                  "Do I have any disease that affects my physical state?",
                  healthQ4.toString()
                  ),
                tableRow(
                  "Habits",
                  "The resting time, food, sport and more, are they adequate?",
                  healthQ5.toString()
                  ),
                tableRow(
                  "Measures",
                  "If I lose my physical condition, do I adopt measures that allow me to recover it satisfactorily?",
                  healthQ6.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  healthAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Personal Growth",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Society",
                  "Do I feel useful to society, do I contribute to the development of my society?",
                  personalQ1.toString()
                  ),
                tableRow(
                  "Current projects",
                  "Am I comfortable with my personal growth plans and projects?",
                  personalQ2.toString()
                  ),
                tableRow(
                  "Future projects",
                  "Do my projects to futures satisfy the perspectives I have to grow?",
                  personalQ3.toString()
                  ),
                tableRow(
                  "Spirituality",
                  "Do I feel good with my spirituality and cultivation constantly?",
                  personalQ4.toString()
                  ),
                tableRow(
                  "Self-esteem",
                  "Do I give true value to my life and my affections?",
                  personalQ5.toString()
                  ),
                tableRow(
                  "Attitudes",
                  "Do I face life in a planned, applied manner and have a will to improve?",
                  personalQ6.toString()
                  ),
                  tableRow(
                  "Skills",
                  "How many skills can I say that I have to do everything that I propose?",
                  personalQ7.toString()
                  ), 
                  tableRow(
                  "Studies",
                  "Am I satisfied with my professional training and I try to move forward?",
                  personalQ8.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  personalAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Country",
                  "Am I satisfied in the country in which I live, according to the current policy, social and cultural environment where I live?",
                  homeQ1.toString()
                  ),
                tableRow(
                  "City",
                  "Do I feel comfortable in the city in which I live and agree with the services it offers?",
                  homeQ2.toString()
                  ),
                tableRow(
                  "District",
                  "Do I like my neighbors and their culture of coexistence?",
                  homeQ3.toString()
                  ),
                tableRow(
                  "Home",
                  "The house where I live satisfies me, has enough space and comfort that I need?",
                  homeQ4.toString()
                  ),
                tableRow(
                  "Coexistence",
                  "Am I comfortable with the people with whom I share my home?",
                  homeQ5.toString()
                  ),
                tableRow(
                  "Home care",
                  "How satisfied am I with the degree of comfort, cleanliness and care that I believe in my home?",
                  homeQ6.toString()
                  ), 
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  homeAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Family & Friends",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Provision",
                  "Do I feel satisfied with the ability I have to find and communicate with new friends or family?",
                  famQ1.toString()
                  ),
                tableRow(
                  "Mother",
                  "Am I satisfied with the relationship I have with my mother?",
                  famQ2.toString()
                  ),
                tableRow(
                  "Father",
                  "Am I satisfied with the relationship I have with my father?",
                  famQ3.toString()
                  ),
                tableRow(
                  "Children",
                  "Am I satisfied with the relationship I have with my children? If I don't have them and I love them, do I do actions to have them?",
                  famQ4.toString()
                  ),
                tableRow(
                  "Close relatives",
                  "How do I feel in my relationships with close relatives: brothers, grandparents, cousins, uncles, etc.?",
                  famQ5.toString()
                  ),
                tableRow(
                  "Friends",
                  "I feel satisfied with the friends I have, do I really have them when I need them and support me?",
                  famQ6.toString()
                  ),
                  tableRow(
                  "Known",
                  "Am I comfortable with the acquaintances I have?",
                  famQ7.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  famAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Love",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Ability \nto love",
                  "May I give myself to my relationships?",
                  loveQ1.toString()
                  ),
                tableRow(
                  "Number \nof \nrelationships",
                  "Am I satisfied with the number of sentimental relationships that I have, or I would like to have other additional relationships?",
                  loveQ2.toString()
                  ),
                tableRow(
                  "Duration",
                  "Am I happy with the time that my relationships last, I do things to keep my partner and give it stability?",
                  loveQ3.toString()
                  ),
                tableRow(
                  "Communication",
                  "Do I understand my partner well, and I am satisfied with the communication and coexistence I have?",
                  loveQ4.toString()
                  ),
                tableRow(
                  "Coexistence",
                  "Do we distribute home tasks?",
                  loveQ5.toString()
                  ),
                tableRow(
                  "Fidelity",
                  "Am I faithful in my relationships, and I have the confidence that my partner is the same?",
                  loveQ6.toString()
                  ),
                  tableRow(
                  "Sexual passion",
                  "Do I have sexual relations with my partner and it attracts me physically?",
                  loveQ7.toString()
                  ), 
                  tableRow(
                  "Emotional Passion",
                  "Do I feel really loved and positively value all the mental and emotional part of my partner?",
                  loveQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  loveAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Free Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Leisure",
                  "Do I have enough leisure time, or do I think it should have more?",
                  freeQ1.toString()
                  ),
                tableRow(
                  "Quality time",
                  "Do I feel that I take advantage of the time I have and take advantage of my leisure?",
                  freeQ2.toString()
                  ),
                tableRow(
                  "Fun",
                  "May I have enough in my leisure times or do I feel bored, and I don't enjoy it?",
                  freeQ3.toString()
                  ),
                tableRow(
                  "Variety",
                  "What other activities do, such as reading, cinema, TV, shows, see photos, study, etc.?",
                  freeQ4.toString()
                  ),
                tableRow(
                  "Tastes",
                  "Am I satisfied doing a sport, practicing a hobby such as playing video games, etc.?",
                  freeQ5.toString()
                  ),
                tableRow(
                  "Participatory",
                  "How do I value the leisure in which I participate with other people, such as a meeting with friends, family, games, etc.?",
                  freeQ6.toString()
                  ),
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  freeAvg.toString(),
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Work",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Working capacity",
                  "I feel satisfied with my performance in the work environment and I really want to work on what I do?",
                  workQ1.toString()
                  ),
                tableRow(
                  "Functions",
                  "Am I satisfied with the functions I perform, and I am developing tasks that generate value in the company?",
                  workQ2.toString()
                  ),
                tableRow(
                  "Company",
                  "Do I feel comfortable in my company and she respects my values?",
                  workQ3.toString()
                  ),
                tableRow(
                  "Boss",
                  "Am I satisfied with my boss or me in my role as a boss?",
                  workQ4.toString()
                  ),
                tableRow(
                  "Companions",
                  "Do I feel that we form a good team with my teammates?",
                  workQ5.toString()
                  ),
                tableRow(
                  "Collaborators",
                  "Do I feel satisfied with the work of my collaborators and we form a good team?",
                  workQ6.toString()
                  ),
                  tableRow(
                  "Recognition",
                  "Am I recognized in my work, I feel that the work I do is valued?",
                  workQ7.toString()
                  ), 
                  tableRow(
                  "Remuneration",
                  "Do I feel satisfied with the economic income and other remuneration that my work gives me?",
                  workQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  workAvg.toString()
                  ),
                  ],
                ),
                const SizedBox(height: 30,),
                Column(
                  children: [
                    const Text(
                  "Money",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Section",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Question",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Answere",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                tableRow(
                  "Belongings",
                  "How do I feel about the belongings I have? Can I satisfy everything I have?",
                  moneyQ1.toString()
                  ),
                tableRow(
                  "Guarantees",
                  "Do I have guarantees that support me financially and I feel sufficient guarantees?",
                  moneyQ2.toString()
                  ),
                tableRow(
                  "Income",
                  "Am I satisfied with the income I have today and are enough to have the standard of living?",
                  moneyQ3.toString()
                  ),
                tableRow(
                  "Future income",
                  "Am I satisfied with the income I will have in the future, and my perspective of economic growth is promising?",
                  moneyQ4.toString()
                  ),
                tableRow(
                  "Bills",
                  "How do I feel about the level of expenses I have. Expenditure above my possibilities?",
                  moneyQ5.toString()
                  ),
                tableRow(
                  "Future expenses",
                  "Do I anticipate many expenses in the future and I feel that I will not be able to cover my future accounts?",
                  moneyQ6.toString()
                  ),
                  tableRow(
                  "Debts",
                  "Am I satisfied with the level of debts I have? Or do I feel very overwhelmed with economic commitments?",
                  moneyQ7.toString()
                  ), 
                  tableRow(
                  "Saving",
                  "I keep some money for bad times, and I'm happy with my savings?",
                  moneyQ8.toString()
                  ),  
                  const SizedBox(height: 10),
                tableRow(
                  "Average",
                  "",
                  moneyAvg.toString()
                  ),
                  ],
                ),
                Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WheelOfLife(adjustData: [
                        {"type": "BaseLine", "index": "Health", "value": baseQ1},
                        {"type": "BaseLine", "index": "Personal Growth", "value": baseQ2},
                        {"type": "BaseLine", "index": "Home", "value": baseQ3},
                        {"type": "BaseLine", "index": "Family & Friends", "value": baseQ4},
                        {"type": "BaseLine", "index": "Love", "value": baseQ5},
                        {"type": "BaseLine", "index": "Free Time", "value": baseQ6},
                        {"type": "BaseLine", "index": "Work", "value": baseQ7},
                        {"type": "BaseLine", "index": "Money", "value": baseQ8},
                
                        {"type": "Results", "index": "Health", "value": healthAvg.toInt()},
                        {"type": "Results", "index": "Personal Growth", "value": personalAvg.toInt()},
                        {"type": "Results", "index": "Home", "value": homeAvg.toInt()},
                        {"type": "Results", "index": "Family & Friends", "value": famAvg.toInt()},
                        {"type": "Results", "index": "Love", "value": loveAvg.toInt()},
                        {"type": "Results", "index": "Free Time", "value": freeAvg.toInt()},
                        {"type": "Results", "index": "Work", "value": workAvg.toInt()},
                        {"type": "Results", "index": "Money", "value": moneyAvg.toInt()},
                ]),
                                        ));
                                  }, 
                                  style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(size.width/4, size.height/40, size.width/4, size.height/40),
                          shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(50)
                              ),),
                                  child: const Text("Send Email")),
              ),
              const Text("Get detailed report and wheel of your life on your email", textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold))
                //     CustomTable(
                // // Replace with your topic names
                // // Replace with your answers
                //     ),
              ])),
        ),
      ),
    ));
  }

  Row tableRow(String section, String question, String answer) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                  section  ,
                    style: const TextStyle(),
                  ),
                  Expanded(
                      child: Text(
                    question,
                    style: const TextStyle(),
                    softWrap: true,
                    textAlign: TextAlign.center,
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
