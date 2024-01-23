import 'dart:async';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/view/auth_screen/login_screen.dart';
import 'package:farm2fabric/trading_platform/widgets_common/applogo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

// creating a method to change screen

changeScreen(){
  Future.delayed(const Duration(seconds: 5), () {
    //using getX
    Get.off(() => loginScreen());
  });
}

@override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children:[
            //splas
            Align( alignment: Alignment.topLeft, child: Image.asset(icSplashBg, width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //splash screen UI is completed
          ],
        )
      )
    );
  }
}