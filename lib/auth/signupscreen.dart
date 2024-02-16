// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:demo_app/auth/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController nameContoll = TextEditingController();

  Future<void> login(String email, String password, String name) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://typescript-al0m.onrender.com/api/user/signUp'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': password,
        }),
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        log('Sign in!');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const SignInScreen()),
            (route) => false);
      } else {
        log('fail!');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // void creatAccount() async {
  //   String email = emailController.text.trim();
  //   String passwor = password.text.trim();
  //   String cpasswor = cpassword.text.trim();

  //   if (email == '' || passwor == '' || cpasswor == '') {
  //     log('Please fill in the detail');
  //   } else {
  //     if (passwor != cpasswor) {
  //       log('Passwords do not match');
  //     } else {
  //       try {
  //         UserCredential userCredential = await FirebaseAuth.instance
  //             .createUserWithEmailAndPassword(email: email, password: passwor);
  //         log('user created');
  //         if (userCredential.user != null) {
  //           Navigator.pop(context);
  //         }
  //       } on FirebaseAuthException catch (e) {
  //         log(e.code.toString());
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const Text('name'),
          TextFormField(
            controller: nameContoll,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'name',
            ),
          ),
          const Text('Email'),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'email',
            ),
          ),
          const Text('Password'),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'password',
            ),
          ),
          const Text('Conform Password'),
          TextFormField(
            controller: cpassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'cpassword',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // creatAccount();
              login(emailController.text, password.text, nameContoll.text);
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
