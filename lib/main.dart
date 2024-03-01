import 'dart:developer';

import 'package:demo_app/api.dart';
import 'package:demo_app/apicall.dart';
import 'package:demo_app/auth/signinscreen.dart';
import 'package:demo_app/firebase_options.dart';
import 'package:demo_app/getprofile.dart';
import 'package:demo_app/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token').toString();

  print("Token ${token}");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token != null ? const GetProfileScreen() : const SignInScreen(),
      //home: EmployeeList(),
    );
  }
}
