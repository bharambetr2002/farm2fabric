import 'dart:async';
import 'package:farm2fabric/authentication/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm2fabric/buyers_side/customer_auth/home_customer.dart';
import 'package:farm2fabric/consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Creating a method to change screen
  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        // Auth check on start
        FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
            if (user == null && mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const loginScreen()),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const Home_Customer()),
              );
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animationController.forward();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(137, 153, 246, 1),
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
              child: Image.asset('assets/images/logo.png', height: 300),
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
                'Farm2Fabric',
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
