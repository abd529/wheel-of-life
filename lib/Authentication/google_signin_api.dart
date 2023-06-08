import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi{
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> signIn()async{
    return await _googleSignIn.signIn();
  }
} 