import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jim_ghana/screens/screen_home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Screenhome(),
      );

  }
}

class Screenhome extends StatefulWidget {
  _ScreenhomeState createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Screen2())));

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