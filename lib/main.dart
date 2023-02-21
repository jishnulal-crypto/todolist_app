import 'package:flutter/material.dart';
import 'package:note_keeper/screens/splash_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {         
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.yellow[200],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow
        )
      ),
    );
  }
}