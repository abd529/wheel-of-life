import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Utilities/table_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;


class PDFScreen extends StatelessWidget {
  final String name = "abd";
  final String userId;
  PDFScreen({super.key, required this.userId});
  
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
                ElevatedButton(
                    onPressed: () {
                      createPdf(userId,context);
                    },
                    child: const Text("Generate PDF")),
                ElevatedButton(
                    onPressed: () {},
                    child: const Text("Save to Cloud Storage")),
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
                const Row(
                  children: [
                    Text(
                      "Name: ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text("Abdullah Ayaz"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Coach: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text("Atif Pervaiz"),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Email: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "atif123@gmail.com",
                          softWrap: true,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    "Based on the answers to the question, this is what you believe your current situation is:"),
                const SizedBox(
                  height: 30,
                ),

                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text(
                            "I am comfortable with my physical and mental health.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("I live in the place I want.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("My family and friends fill my life.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("I live in harmony and peace.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("I take my free spaces.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("I am professionally satisfied.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text("Administer well the money I have.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                        width: size.width - 50,
                        child: const Text(
                            "I am comfortable with my physical and mental health.",
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    Container(
                      child: const Text("5"),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Mood",
                      style: TextStyle(),
                    ),
                    Expanded(
                        child: Text(
                      "Is there anything that alters my psychological state?",
                      style: TextStyle(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    )),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "1",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Psychological state",
                          style: TextStyle(),
                        )),
                    Expanded(
                        child: Text(
                            "Do I carry out activities that move me away from a state of tension, nerves, stress, etc.?",
                            style: TextStyle(),
                            softWrap: true,
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Personal care",
                          style: TextStyle(),
                        )),
                    Expanded(
                        child: Text(
                            "When I am discouraged, I adopt measures that allow me to recover it adequately and quickly?",
                            style: TextStyle(),
                            softWrap: true,
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Physical state",
                          style: TextStyle(),
                        )),
                    Expanded(
                        child: Text(
                            "Do I have any disease that affects my physical state?",
                            style: TextStyle(),
                            softWrap: true,
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Habits",
                          style: TextStyle(),
                        )),
                    Expanded(
                        child: Text(
                            "The resting time, food, sport and more, are they adequate?",
                            style: TextStyle(),
                            softWrap: true,
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          "Measures",
                          style: TextStyle(),
                        )),
                    Expanded(
                        child: Text(
                            "If I lose my physical condition, do I adopt measures that allow me to recover it satisfactorily?",
                            style: TextStyle(),
                            softWrap: true,
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: TextStyle(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 150,
                ),
                //     CustomTable(
                // // Replace with your topic names
                // // Replace with your answers
                //     ),
              ])),
        ),
      ),
    ));
  }
}
