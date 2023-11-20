import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jim_ghana/screens/screen_home.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScreenHome())));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80,
          width: 200,
          child: const Column(
            children: [
              Text('JIMGHANA',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, ),),
              Text(' DRIVER APP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),

            ],
          ),
        ),
      ),
    );
  }

}