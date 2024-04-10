import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const sellerapp());
}

class sellerapp extends StatelessWidget {
  const sellerapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm2fabric Seller side',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
