// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '/Quiz%20Functionality/Quiz/health_quiz.dart';



class BaseLineQuiz extends StatefulWidget {
  static const routeName = "my-BaseLinequiz";
  final String userId;
  const BaseLineQuiz({super.key, required this.userId});

  @override
  State<BaseLineQuiz> createState() => _BaseLineQuizState();
}

class _BaseLineQuizState extends State<BaseLineQuiz> {
  
  
  List<String> images = ["assets/health.png","assets/personal growth.png","assets/home.png" ,"assets/family-friends.png","assets/love.png","assets/free-time.png","assets/work.png","assets/money.png" ];
  int index = 0;
  int _currentValue = 5;
  int BaseAns1 = 0;
  int BaseAns2 = 0;
  int BaseAns3 = 0;
  int BaseAns4 = 0;
  int BaseAns5 = 0;
  int BaseAns6 = 0;
  int BaseAns7 = 0;
  int BaseAns8 = 0;
  

  @override
  Widget build(BuildContext context) {
    List<String> Questions = [
    "Q1: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q2: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q3: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q4: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q5: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q6: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q7: ${AppLocalizations.of(context)!.baseLineQuestion}",
    "Q8: ${AppLocalizations.of(context)!.baseLineQuestion}",
    AppLocalizations.of(context)!.baslineCompleted,
    ];
    List<String> topic = [
      AppLocalizations.of(context)!.health,
      AppLocalizations.of(context)!.personalG,
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.famFriends,
      AppLocalizations.of(context)!.love,
      AppLocalizations.of(context)!.freeTime,
      AppLocalizations.of(context)!.work,
      AppLocalizations.of(context)!.money,];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              Column(children: [
                Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const BackButton(),
                  //index<=7? Text(topic[index], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),):const SizedBox(height: 20,),
                   Image.asset(
                         "assets/logo.png",
                          width: size.width/1.8,
                          height: size.height/8,
                          //fit: BoxFit.cover,
                        ),
                    SizedBox(width: size.width/8,)
                ]),
                ),
              ],),
              Column(
                children: [
                  index<=7? Text(topic[index], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),):const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(Questions[index],textAlign: TextAlign.center ,style: const TextStyle(fontSize: 18),)),
              ),
                index<=7? Image.asset(images[index], height: size.height/3.5,width: size.width/1):const SizedBox(height:20), 
                SizedBox(height: size.height/70,),
              index>7? const SizedBox(height: 20,): NumberPicker(
                itemCount: 3,
              selectedTextStyle: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold, ),
              textStyle: const TextStyle(fontSize: 18,color: Colors.deepPurple),
              axis: Axis.horizontal,
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                color: Colors.deepPurple.withOpacity(0.4)
              ),
              value:_currentValue,
              minValue: 1,
              maxValue: 10,
              onChanged: (value) { setState(()=> _currentValue = value);},),
              SizedBox(height: size.height/50,),
                ],
              ),
              Column(
                children: [
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:index<=7? MainAxisAlignment.spaceBetween:MainAxisAlignment.center ,
                  children: [
                   if(index<=7)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(size.width/8, size.height/50, size.width/8, size.height/50),
                                shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                                    ),),
                      onPressed: (){
                        if(index>0){
                          setState(() {
                            index--;
                          });
                        }
                      }, child: const Text("Previous")),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(size.width/9, size.height/50, size.width/9, size.height/50),
                                shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                                    ),),
                      onPressed: (){
                      if(index<=7){
                        if(index==0){
                          setState(() {
                          BaseAns1 = _currentValue;
                          print("the ans to Q1 is $BaseAns1");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==1){
                          setState(() {
                          BaseAns2 = _currentValue;
                          print("the ans to Q2 is $BaseAns2");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==2){
                          setState(() {
                          BaseAns3 = _currentValue;
                          print("the ans to Q3 is $BaseAns3");
                          _currentValue = 5;
                          index++;
                            
                          }); 
                        }
                        else if(index==3){
                          setState(() {
                          BaseAns4 = _currentValue;
                          print("the ans to Q4 is $BaseAns4");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==4){
                          setState(() {
                          BaseAns5 = _currentValue;
                          print("the ans to Q5 is $BaseAns5");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==5){
                          setState(() {BaseAns6 = _currentValue;
                          print("the ans to Q6 is $BaseAns6");
                          _currentValue = 5;
                          index++;
                          });
                          }
                        else if(index==6){
                          setState(() {
                          BaseAns7 = _currentValue;
                          print("the ans to Q7 is $BaseAns7");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==7){
                          setState(() {
                          BaseAns8 = _currentValue;
                          print("the ans to Q8 is $BaseAns8");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                      }
                      else{
                        FirebaseFirestore.instance
                              .collection("User Answers") 
                              .doc(widget.userId).collection("Base Line").doc(widget.userId).set({
                            "Q1": BaseAns1,
                            "Q2": BaseAns2,
                            "Q3": BaseAns3,
                            "Q4": BaseAns4,
                            "Q5": BaseAns5,
                            "Q6": BaseAns6,
                            "Q7": BaseAns7,
                            "Q8": BaseAns8,
                          });
                        print("Data Stored and UserId is ${widget.userId}");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HealthQuiz(userId: widget.userId),))
                        .then((value){
                          setState(() {
                            index = 0;
                          });
                        });
                        
                      }
                    }, child:  index<=7? Text(AppLocalizations.of(context)!.next):Text(AppLocalizations.of(context)!.moveToDetailedQuestions, textAlign: TextAlign.center,) ),
                  ],
                ),
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
                          child: Text(
                            AppLocalizations.of(context)!.skip,
                            style:const TextStyle(color: Colors.white),
                          ),
                        ): const SizedBox()
                ],
              )
              
              ]),
        ),
      ),
    );
  }
}