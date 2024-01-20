import 'package:farm2fabric/view/home.dart';
import 'package:flutter/material.dart';
import 'package:farm2fabric/view/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showingSplash = true;
  LoadHome() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showingSplash = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Snack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showingSplash ? SplashScreen() : HomeScreen(),
    );
  }
}

