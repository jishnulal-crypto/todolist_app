import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_keeper/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen())));

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image(height: 150, width: 150, image: AssetImage('assets/logo.png'))),
          SizedBox(height: 50),
          Center(child: Text('Note Keeper',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.yellow[900]),))
        ],
      ),
    );
  }
}
