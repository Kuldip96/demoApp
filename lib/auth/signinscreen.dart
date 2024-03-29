import 'dart:convert';
import 'dart:developer';
import 'package:demo_app/auth/signupscreen.dart';
import 'package:demo_app/getprofile.dart';
import 'package:demo_app/view/home/home_screen.dart';
import 'package:demo_app/view/storage/storage_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String passwor = password.text.trim();

    if (email == '' || passwor == '') {
      log('Please fill in the detail');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: passwor);
        log('user created');
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => StorageScreen()));
        }
      } on FirebaseAuthException catch (e) {
        log(e.code.toString());
      }
    }
  }
  // Future<void> login(String email, String password) async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse('http://restapi.adequateshop.com/api/authaccount/login'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode({
  //         'email': email,
  //         'password': password,
  //       }),
  //     );

  //     log(response.statusCode.toString());
  //     var data = jsonDecode(response.body);
  //     //log(data['message']);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       //log(data['token']);
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('token', data['data']['Token']);
  //       final Token = prefs.getString('token');
  //       log('login!!');
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //               builder: (_) => HomeScreen(
  //                     token1: Token,
  //                   )),
  //           (route) => false);
  //     } else {
  //       log('Fail!');
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
  // Future<void> login(String email, String password) async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse('https://typescript-al0m.onrender.com/api/user/login'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode({
  //         'email': email,
  //         'password': password,
  //       }),
  //     );

  //     log(response.statusCode.toString());
  //     var data = jsonDecode(response.body);
  //     log(data['message']);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       log(data['token']);
  //       final SharedPreferences prefs = await SharedPreferences.getInstance();
  //       prefs.setString('token', data['token']);
  //       final Token = prefs.getString('token');
  //       log('login!!');
  //       if (Token != "") {
  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (_) => const GetProfileScreen()),
  //             (route) => false);
  //       }
  //     } else {
  //       log('Fail!');
  //     }
  //   } catch (e) {
  //     log("iji");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          const Text('email'),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'email',
            ),
          ),
          const Text('password'),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'password',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: const Text('Login'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignUpScreen(),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
