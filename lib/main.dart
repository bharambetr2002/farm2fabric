import 'package:farm2fabric/view/dashboard.dart';
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
    super.initState();
    LoadHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm2Fabric',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showingSplash ? SplashScreen() : Dashboard(),
    );
  }
}

