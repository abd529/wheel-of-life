import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CoachFilter extends StatefulWidget {
  static const routeName = "coach filter";
  const CoachFilter({super.key});

  @override
  State<CoachFilter> createState() => _CoachFilterState();
}

class _CoachFilterState extends State<CoachFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: SafeArea(child: 
        SizedBox(width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: SvgPicture.asset("assets/logo.svg")),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:   [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Coach Filter Selection", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I want a coach for these characteristis to contact me")),
                      Text("Gender"),
                      Divider(),
                      Row(
                        children: [
                          Text("Male"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Female"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Text("Badges"),
                      Divider(),
                      Row(
                        children: [
                          Text("Black Ribbon"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("500 +  Sessions"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Virtual only"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Local"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Text("language"),
                      Divider(),
                      Row(
                        children: [
                          Text("Chinese"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Espanol"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Portoguese"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Francis"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("English"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      Row(
                        children: [
                          Text("Italian"),
                          Radio(value: true, groupValue: false, onChanged:(chng){} )
                        ],
                      ),
                      
                      
                      
                        const SizedBox(height: 30,),
                        ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                            shape: RoundedRectangleBorder( //to set border radius to button
                      borderRadius: BorderRadius.circular(50)
                                ),
                        ),
                           child: const Text("Send") ),
                        
                       
                  ],
                ),
              ),
              
          ],
        ),
        )
        ),
      ),
    );
  }
}