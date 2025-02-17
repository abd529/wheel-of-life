// ignore_for_file: unnecessary_null_comparison, avoid_print, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  String message = "";
  //var userId = uuid.v4();

  Future<bool> register(
      String email, String password, String fName, String lName) async {
    bool isRegistered = false;

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(fName);
      isRegistered = userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        message = "Password is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "Email already in use";
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return isRegistered;
  }
}