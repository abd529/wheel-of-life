import 'package:flutter/material.dart';

import '../main.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = "language-screen";
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  void changeLocale(value) {
    MyApp.setLocale(context, Locale(value));
  }

  @override
  Widget build(BuildContext context) {
    String lang = Localizations.localeOf(context).toString();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
             const Align(
                alignment: Alignment.centerLeft,
                child: Text("Choose Your Language", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Espanol", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "es", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Portuguese", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "pt", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Francias", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "fr", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("English", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "en", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Italiano", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "it", groupValue: lang, onChanged: changeLocale),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("中文的", style: TextStyle(fontSize: 16)),
                  Radio(
                      value: "zh", groupValue: lang, onChanged: changeLocale),
                ],
              ),
          ]),
          ) 
        ),
    );
  }
}