import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/category_news.dart';
import 'package:flutter_news_app/screen/forgot_password.dart';
import 'package:flutter_news_app/screen/home.dart';
import 'package:flutter_news_app/screen/login.dart';
import 'package:flutter_news_app/screen/signUp.dart';
import 'package:flutter_news_app/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _currentUser=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: ForgotPassword(),
      //home: _currentUser==null?Login():LandingScreen(),
    );
  }
}
