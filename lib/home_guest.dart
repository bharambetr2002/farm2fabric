import 'package:farm2fabric/market_information/view/news_main.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsScreen()),
            );
          },
          child: Text('Go to Market Information')
        ),
    ),
    );  
  }
}