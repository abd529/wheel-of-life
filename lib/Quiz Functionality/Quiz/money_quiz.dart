// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:numberpicker/numberpicker.dart';
import '/Screens/report.dart';

class MoneyQuiz extends StatefulWidget {
  static const routeName = "my-money-quiz";
  final String userId;
  const MoneyQuiz({super.key, required this.userId});

  @override
  State<MoneyQuiz> createState() => _MoneyQuizState();
}

class _MoneyQuizState extends State<MoneyQuiz> {
  // List<String> Questions = [
  //   "Q1: How do I feel about the belongings I have? Can I satisfy everything I have?",
  //   "Q2: Do I have guarantees that support me financially and I feel sufficient guarantees?",
  //   "Q3: Am I satisfied with the income I have today and are enough to have the standard of living?",
  //   "Q4: Am I satisfied with the income I will have in the future, and my perspective of economic growth is promising?",
  //   "Q5: How do I feel about the level of expenses I have. Expenditure above my possibilities?",
  //   "Q6: Do I anticipate many expenses in the future and I feel that I will not be able to cover my future accounts?",
  //   "Q7: Am I satisfied with the level of debts I have? Or do I feel very overwhelmed with economic commitments?",
  //   "Q8: I keep some money for bad times, and I'm happy with my savings?",
  //   "Money questions are completed ",
  // ];
  
  int index = 0;
  int _currentValue = 5;
  int ans1 = 0;
  int ans2 = 0;
  int ans3 = 0;
  int ans4 = 0;
  int ans5 = 0;
  int ans6 = 0;
  int ans7 = 0;
  int ans8 = 0;


  @override
  Widget build(BuildContext context) {

    List<String> topic = [
    AppLocalizations.of(context)!.belongings,
    AppLocalizations.of(context)!.guarantees,
    AppLocalizations.of(context)!.income,
    AppLocalizations.of(context)!.futureIncome,
    AppLocalizations.of(context)!.bills,
    AppLocalizations.of(context)!.futureExpenses,
    AppLocalizations.of(context)!.debts,
    AppLocalizations.of(context)!.saving
  ];


    List<String> Questions = [
    (AppLocalizations.of(context)!.moneyQone),
    (AppLocalizations.of(context)!.moneyQtwo),
    (AppLocalizations.of(context)!.moneyQthree),
    (AppLocalizations.of(context)!.moneyQfour),
    (AppLocalizations.of(context)!.moneyQfive),
    (AppLocalizations.of(context)!.moneyQsix),
    (AppLocalizations.of(context)!.moneyQseven),
    (AppLocalizations.of(context)!.moneyQeight),
    AppLocalizations.of(context)!.questionsCompleted,
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(),
                        Image.asset(
                       "assets/logo.png",
                        width: size.width/1.8,
                        height: size.height/8,
                        //fit: BoxFit.cover,
                      ),
                        const SizedBox(
                          width: 50,
                        )
                      ]),
                ),
                  ],
                ),
                //const SizedBox(height: 50),
                Column(children: [
                  Container(
                  color: Colors.deepPurple.withOpacity(0.3),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.section,
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.money,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.deepPurple.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "${AppLocalizations.of(context)!.subject}: ",
                        style: const TextStyle(fontSize: 18),
                      ),
                      index <= 7
                          ? Text(
                              topic[index],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(
                              height: 20,
                            )
                    ],
                  ),
                ),
                ],),
                // const SizedBox(
                //   height: 50,
                // ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Questions[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 80,
                // ),
                Column(
                  children: [
                    index > 7
                    ? const SizedBox(
                        height: 20,
                      )
                    : NumberPicker(
                        itemCount: 3,
                        selectedTextStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textStyle: const TextStyle(
                            fontSize: 18, color: Colors.deepPurple),
                        axis: Axis.horizontal,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            shape: BoxShape.circle,
                            color: Colors.deepPurple.withOpacity(0.4)),
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 10,
                        onChanged: (value) {
                          setState(() => _currentValue = value);
                        },
                      ),
                  ],
                ),
                // const SizedBox(
                //   height: 40,
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                    mainAxisAlignment: index <= 7
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      index <= 7
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if(index>=1){
                                    index--;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding:EdgeInsets.fromLTRB(size.width/8, size.height/40, size.width/8, size.height/40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              child:Text(AppLocalizations.of(context)!.previous))
                          : const SizedBox(
                              height: 10,
                            ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:EdgeInsets.fromLTRB(size.width/6.5, size.height/40, size.width/6.5, size.height/40),
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(50))),
                          onPressed: () {
                            if (index <= 7) {
                              if (index == 0) {
                                setState(() {
                                  ans1 = _currentValue;
                                  print("the ans to Q1 is $ans1");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 1) {
                                setState(() {
                                  ans2 = _currentValue;
                                  print("the ans to Q2 is $ans2");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 2) {
                                setState(() {
                                  ans3 = _currentValue;
                                  print("the ans to Q3 is $ans3");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 3) {
                                setState(() {
                                  ans4 = _currentValue;
                                  print("the ans to Q4 is $ans4");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 4) {
                                setState(() {
                                  ans5 = _currentValue;
                                  print("the ans to Q5 is $ans5");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 5) {
                                setState(() {
                                  ans6 = _currentValue;
                                  print("the ans to Q6 is $ans6");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 6) {
                                setState(() {
                                  ans7 = _currentValue;
                                  print("the ans to Q7 is $ans7");
                                  _currentValue = 5;
                                  index++;
                                });
                              } else if (index == 7) {
                                setState(() {
                                  ans8 = _currentValue;
                                  print("the ans to Q8 is $ans8");
                                  _currentValue = 5;
                                  index++;
                                });
                              }
                            } else {
                              FirebaseFirestore.instance
                                  .collection("User Answers")
                                  .doc(widget.userId)
                                  .collection("Money")
                                  .doc(widget.userId)
                                  .set({
                                "Q1": ans1,
                                "Q2": ans2,
                                "Q3": ans3,
                                "Q4": ans4,
                                "Q5": ans5,
                                "Q6": ans6,
                                "Q7": ans7,
                                "Q8": ans8,
                                "Average": (ans1 +
                                        ans2 +
                                        ans3 +
                                        ans4 +
                                        ans5 +
                                        ans6 +
                                        ans7 +
                                        ans8) /
                                    8
                              });
                              print("Data Stored and UserId is ${widget.userId}");
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(userId: widget.userId),))
                              .then((value){
                          setState(() {
                            index = 0;
                          });
                        });
                            }
                          },
                          child: index <= 7
                             ? Text(AppLocalizations.of(context)!.next)
                              : SizedBox(
                                width: 220,
                                child: Text(AppLocalizations.of(context)!.moveToNext,softWrap: true,textAlign: TextAlign.center,))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  index <= 7
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                index++;
                                _currentValue = 5;
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.withOpacity(0.3),
                              padding:EdgeInsets.fromLTRB(size.width/8, size.height/40, size.width/8, size.height/40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child:  Text(
                            AppLocalizations.of(context)!.skip,
                            style:const TextStyle(color: Colors.white),
                          ),
                        )
                      : const SizedBox(
                          height: 20,
                        )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
