import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

import './Authentication/signup_screen.dart';
import './Screens/lanugage_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '/Authentication/forgot_password.dart';
import '/Quiz%20Functionality/quiz_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '/Screens/home_screen.dart';
import 'Authentication/login_screen.dart';
import 'Screens/email.dart';
import 'Screens/onboard_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey =
  //     "pk_test_51IPZIqK66jUbxaJOqYosJCBW8656t1FTX8ShRaze4nFOhuE2qtIndRqTyklIvaXyOir5otUDcfjei0E4kETP53sS00EUOIuOyf";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "assets/.env");
  var uid = const Uuid().v4();
  runApp(MyApp(
    uid: uid,
  ));
}

class MyApp extends StatefulWidget {
  final String uid;
  MyApp({super.key, required this.uid});

  //@overriden
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("en");
  setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      title: "True North",
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
      supportedLocales: L10n.all,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      routes: {
        logQuiz.routeName: (ctx) => const logQuiz(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        //VideoScreen.routeName: (ctx) => VideoScreen(),
        //DetailPage.routeName: (ctx) => const DetailPage(),
        // BaseLineQuiz.routeName: (ctx) => const BaseLineQuiz(),
        ForgotPassword.routeName: (ctx) => ForgotPassword(),
        EmailSend.routeName: (ctx) => EmailSend(),
        // StripePayment.routeName: (ctx) => const StripePayment(),
        Onboard.routeName: (ctx) => const Onboard(),
        // HealthQuiz.routeName: (ctx) => const HealthQuiz(),
        // PersonalQuiz.routeName: (ctx) => const PersonalQuiz(),
        // HomeQuiz.routeName: (ctx) => const HomeQuiz(),
        // FamilyQuiz.routeName: (ctx) => const FamilyQuiz(),
        // LoveQuiz.routeName: (ctx) => const LoveQuiz(),
        // FreeQuiz.routeName: (ctx) => const FreeQuiz(),
        // WorkQuiz.routeName: (ctx) => const WorkQuiz(),
        // MoneyQuiz.routeName: (ctx) => const MoneyQuiz(),
        HomeScreen.routeName: (ctx) => HomeScreen(
              uid: widget.uid,
            ),
        LanguageScreen.routeName: (ctx) => const LanguageScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
      },
    );
  }
}
