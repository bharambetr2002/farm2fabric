import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animationController.forward();
    Timer(const Duration(seconds: 5), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(137, 153, 246, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.bounceOut,
                ),
              ),
              child: Image.asset('assets/img/logo.png', height: 300),
            ),
            const SizedBox(
              height: 10,
            ),
            ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.bounceOut,
                ),
              ),
              child: const Text(
                'Farm to Fabric',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const SizedBox(
        height: 50,
        child: Text('Uniting Wool, Sustaining Tradition, Cultivating Tomorrow',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'italic', fontSize: 14, color: Colors.white)),
      ),
    );
  }
}