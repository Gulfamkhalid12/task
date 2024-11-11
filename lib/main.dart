// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/firebase_options.dart';
import 'package:task/presentation/pages/homepage.dart';
import 'package:task/presentation/pages/login_screen.dart';
 
 

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:  DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  
  final auth = FirebaseAuth.instance;
  bool? value;
  @override
  void initState() {
    super.initState();
    getBool();
  }
  Future<bool?> getBool () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      value =  prefs.getBool('login_sucess');
    });
    return value;
  }
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: value!=true?LoginScreen():Homepage(),

    );
    
  }

 
}
 
 
   
   
 
