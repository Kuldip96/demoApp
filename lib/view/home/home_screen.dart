// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:demo_app/Models/show_product_model.dart';
import 'package:demo_app/auth/signinscreen.dart';
import 'package:demo_app/utils/comman/comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  String? token1;
  HomeScreen({Key? key, this.token1}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FackData> data = [];

  @override
  void initState() {
    super.initState();
    fetchData(widget.token1 ?? "");
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          AppText.HomePageName,
        ),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length ,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text("ID: ${item.data?[index].id ?? "dfe"}"),
            subtitle: Text("Name: ${item.data?[index].email ?? "ed"}"),
          );
        },
      ),
    );
  }

  Future<void> fetchData(String token) async {
    final response = await http.get(
      Uri.parse('http://restapi.adequateshop.com/api/users'),
      headers: {'Authorization': 'Bearer $token'}, // Pass token in headers
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<FackData> fetchedData = [];

      for (var item in jsonData) {
        fetchedData.add(FackData.fromJson(item));
      }

      setState(() {
        data = fetchedData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
