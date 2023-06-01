import 'package:com.example.wheel_of_life/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/Authentication/forgot_password.dart';
import '/Quiz%20Functionality/Quiz/family_quiz.dart';
import '/Quiz%20Functionality/Quiz/health_quiz.dart';
import '/Quiz%20Functionality/Quiz/home_quiz.dart';
import '/Quiz%20Functionality/Quiz/love_quiz.dart';
import '/Quiz%20Functionality/Quiz/money_quiz.dart';
import '/Quiz%20Functionality/Quiz/p_growth_quiz.dart';
import '/Quiz%20Functionality/Quiz/work_quiz.dart';
import '/Quiz%20Functionality/quiz_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '/Screens/home_screen.dart';
import '/Screens/onboard_screen.dart';
import '/Screens/stripe_payment.dart';
import '/Screens/youtube_screen.dart';
import 'Authentication/login_screen.dart';
import 'Quiz Functionality/Quiz/baseline_quiz.dart';
import 'Quiz Functionality/Quiz/free_quiz.dart';
import 'Screens/email.dart';
import 'Screens/report.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51IPZIqK66jUbxaJOqYosJCBW8656t1FTX8ShRaze4nFOhuE2qtIndRqTyklIvaXyOir5otUDcfjei0E4kETP53sS00EUOIuOyf";
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
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
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.purple,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? Onboard()
          : LoginScreen(),
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
        VideoScreen.routeName: (ctx) => VideoScreen(),
        DetailPage.routeName: (ctx) => const DetailPage(),
        BaseLineQuiz.routeName: (ctx) => const BaseLineQuiz(),
        ForgotPassword.routeName: (ctx) => ForgotPassword(),
        EmailSend.routeName: (ctx) => EmailSend(),
        StripePayment.routeName: (ctx) => const StripePayment(),
        Onboard.routeName: (ctx) => const Onboard(),
        HealthQuiz.routeName: (ctx) => const HealthQuiz(),
        PersonalQuiz.routeName: (ctx) => const PersonalQuiz(),
        HomeQuiz.routeName: (ctx) => const HomeQuiz(),
        FamilyQuiz.routeName: (ctx) => const FamilyQuiz(),
        LoveQuiz.routeName: (ctx) => const LoveQuiz(),
        FreeQuiz.routeName: (ctx) => const FreeQuiz(),
        WorkQuiz.routeName: (ctx) => const WorkQuiz(),
        MoneyQuiz.routeName: (ctx) => const MoneyQuiz(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        StripePayment3.routeName: (ctx) => const StripePayment3()
      },
    );
  }
}
