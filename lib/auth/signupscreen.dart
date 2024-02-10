import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  void creatAccount() async {
    String email = emailController.text.trim();
    String passwor = password.text.trim();
    String cpasswor = cpassword.text.trim();

    if (email == '' || passwor == '' || cpasswor == '') {
      log('Please fill in the detail');
    } else {
      if (passwor != cpasswor) {
        log('Passwords do not match');
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: passwor);
          log('user created');
          if (userCredential.user != null) {
            Navigator.pop(context);
          }
        } on FirebaseAuthException catch (e) {
          log(e.code.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
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
              creatAccount();
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
