import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CoachFilter extends StatefulWidget {
  static const routeName = "coach filter";
  const CoachFilter({super.key});

  @override
  State<CoachFilter> createState() => _CoachFilterState();
}

class _CoachFilterState extends State<CoachFilter> {
  bool genderGroupValue = false;
  bool genderMaleValue = false;
  bool genderFemaleValue = false;
  String selectedGender = "";
  String selectedBadge = "";
  String selectedLanguage = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: 
      SingleChildScrollView(
        child: SafeArea(child: 
        SizedBox(width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              child: Image.asset(
                "assets/logo.png",
                height: size.height/8,
                width: size.width/2,
                fit: BoxFit.cover,)),
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
                      const Text("Gender", style: TextStyle(fontSize: 16),),
                      const Divider(),
                     
                      RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
                      const Text("Badges", style: TextStyle(fontSize: 16)),
                      const Divider(),
                      RadioListTile<String>(
              title: const Text('Black Ribbon'),
              value: 'Black Ribbon',
              groupValue: selectedBadge,
              onChanged: (value) {
                setState(() {
                  selectedBadge = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('500+ Sessions'),
              value: '500+ Sessions',
              groupValue: selectedBadge,
              onChanged: (value) {
                setState(() {
                  selectedBadge = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Virtual Only'),
              value: 'Virtual Only',
              groupValue: selectedBadge,
              onChanged: (value) {
                setState(() {
                  selectedBadge = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Local'),
              value: 'Local',
              groupValue: selectedBadge,
              onChanged: (value) {
                setState(() {
                  selectedBadge = value!;
                });
              },
            ),
                      const Text("Language", style: TextStyle(fontSize: 16)),
                      const Divider(),
                      RadioListTile<String>(
              title: const Text('Chinese'),
              value: 'Chinese',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'Español',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Portoguese'),
              value: 'Portoguese',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('French'),
              value: 'French',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Italian'),
              value: 'Italian',
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
            ),
                      
                      
                      
                        const SizedBox(height: 30,),
                        ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
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