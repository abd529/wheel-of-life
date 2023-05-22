// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '/Quiz%20Functionality/Quiz/work_quiz.dart';
import '/Screens/onboard_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';



class FreeQuiz extends StatefulWidget {
  static const routeName = "my-free-quiz";
  const FreeQuiz({super.key});

  @override
  State<FreeQuiz> createState() => _FreeQuizState();
}

class _FreeQuizState extends State<FreeQuiz> {
  List<String> Questions = [
    "Q1: Do I have enough leisure time, or do I think it should have more?",
    "Q2: Do I feel that I take advantage of the time I have and take advantage of my leisure?",
    "Q3: May I have enough in my leisure times or do I feel bored, and I don't enjoy it?",
    "Q4: What other activities do, such as reading, cinema, TV, shows, see photos, study, etc.?",
    "Q5: Am I satisfied doing a sport, practicing a hobby such as playing video games, etc.?",
    "Q6: How do I value the leisure in which I participate with other people, such as a meeting with friends, family, games, etc.?",
    "Free Time questions are completed",
    ];
  List<String> topic = ["Leisure","Quality Time","Fun","Variety","Tastes","Participatory",];
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
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const BackButton(),
                    Center(
                        child: 
                        SvgPicture.asset(
                                     "assets/logo.svg",
                                     width: 85,
                                     height: 85,
                                    ),
                      ),                    const SizedBox(width: 50,)
                  ]),
                  ),
                  const SizedBox(height:50),
                  Container(
                    color: Colors.purple.withOpacity(0.3),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Section", style: TextStyle(fontSize: 18),)],),
                  ),
                  const SizedBox(height: 10),
                  const Text("Free Time",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.purple.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Subject: ", style: TextStyle(fontSize: 18),),
                        index<=5? Text(topic[index], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),):const SizedBox(height: 20,)
                        ],),
                  ),
                  const SizedBox(height: 50,),
                  Align(
                  alignment: Alignment.center,
                  child: Text(Questions[index],textAlign: TextAlign.center ,style: const TextStyle(fontSize: 18),)),
                  const  SizedBox(height: 80,),
                index>5? const SizedBox(height: 20,): NumberPicker(
                  itemCount: 3,
                selectedTextStyle: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold, ),
                textStyle: const TextStyle(fontSize: 18,color: Colors.deepPurple),
                axis: Axis.horizontal,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle,
                  color: Colors.purple.withOpacity(0.4)
                ),
                value:_currentValue,
                minValue: 1,
                maxValue: 10,
                onChanged: (value) { setState(()=> _currentValue = value);},),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: index <=5 ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                  children: [
                    index<=5? ElevatedButton(onPressed: (){
                      setState(() {
                        index--;
                      });
                    }, 
                    style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                              shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(50)
                       ) ),
                    child: const Text("Previous")):SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                              shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(50)
                       ) ),
                      onPressed: (){
                      if(index<=5){
                        if(index==0){
                          setState(() {
                          ans1 = _currentValue;
                          print("the ans to Q1 is $ans1");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==1){
                          setState(() {
                          ans2 = _currentValue;
                          print("the ans to Q2 is $ans2");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==2){
                          setState(() {
                          ans3 = _currentValue;
                          print("the ans to Q3 is $ans3");
                          _currentValue = 5;
                          index++;
                            
                          }); 
                        }
                        else if(index==3){
                          setState(() {
                          ans4 = _currentValue;
                          print("the ans to Q4 is $ans4");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==4){
                          setState(() {
                          ans5 = _currentValue;
                          print("the ans to Q5 is $ans5");
                          _currentValue = 5;
                          index++; 
                          });
                        }
                        else if(index==5){
                          setState(() {ans6 = _currentValue;
                          print("the ans to Q6 is $ans6");
                          _currentValue = 5;
                          index++;
                          });
                          }
                      }
                      else{
                        //Store Data to Fire Store
                        FirebaseFirestore.instance
              .collection("User Answers") //folder
              .doc(userId).collection("Free Time").doc(userId).set({
            "Q1": ans1,
            "Q2": ans2,
            "Q3": ans3,
            "Q4": ans4,
            "Q5": ans5,
            "Q6": ans6,
            "Average": (ans1+ans2+ans3+ans4+ans5+ans6)/6
          });
                        print("Data Stored and UserId is $userId");
                        Navigator.of(context).pushNamed(WorkQuiz.routeName);
        
                      }
                    }, child:  index<=5? const Text("Next"):const Text("Move to next section") ),
                  ],
                ),
                const SizedBox(height: 20,),
                index<=5?ElevatedButton(onPressed: (){
                  setState(() {
                    setState(() {
                    index++;
                    _currentValue = 5;                      
                    });
                  });
                }, style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.withOpacity(0.3),
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                   ) ), child: const Text("Skip", style: TextStyle(color: Colors.black),),)
                : SizedBox(height: 20,)
                
                ]),
          ),
        ),
      ),
    );
  }
}