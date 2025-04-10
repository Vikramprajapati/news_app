import 'package:flutter/material.dart';
import 'package:flutter_news_app/screen/category_news.dart';
import 'package:flutter_news_app/screen/home.dart';
import 'package:flutter_news_app/screen/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}
