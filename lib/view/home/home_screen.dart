import 'dart:convert';
import 'dart:developer';

import 'package:demo_app/Models/show_product_model.dart';
import 'package:demo_app/auth/signinscreen.dart';
import 'package:demo_app/utils/comman/comman_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  String? token1;
  HomeScreen({super.key, this.token1});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? tokeeen;
  @override
  void initState() {
    setState(() {
      getToken();
    });
    tokeeen = widget.token1;
    super.initState();
  }

  String Token = "";
  void getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final Token = prefs.getString('token');
    log("tokeeen ${Token!}");
    // userGet(Token);
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInScreen()));
  }

  List<ProductGet> futureData = [];
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<ProductGet>>(
          future: userGet(tokeeen ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(snapshot.data?[index].productName ?? "N/A"),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<ProductGet>> userGet(String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://typescript-al0m.onrender.com/api/user/product/showall-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is List) {
          List<ProductGet> products = [];
          for (var item in data) {
            print(item);
            products.add(ProductGet.fromJson(item));
          }
          setState(() {
            futureData = products;
          });
          return products;
        } else {
          print('Unexpected data format: $data');
          throw 'Unexpected data format: $data';
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print('Error: $e');
      throw 'Error: $e';
    }
  }
}
