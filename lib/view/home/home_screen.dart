import 'dart:convert';
import 'dart:developer';

import 'package:demo_app/Models/show_product_model.dart';
import 'package:demo_app/auth/signinscreen.dart';
import 'package:demo_app/utils/comman/app_botton.dart';
import 'package:demo_app/utils/comman/app_color.dart';
import 'package:demo_app/utils/comman/app_text.dart';
import 'package:demo_app/utils/comman/comman_text.dart';
import 'package:demo_app/view/home/second_screen.dart';
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
        child: FutureBuilder<ProductGet?>(
            future: userGet(tokeeen ?? ""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: futureData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(snapshot.data?.productName ?? "dwe"),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<ProductGet?> userGet(String token) async {
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
            futureData.add(ProductGet.fromJson(item));
            products.add(ProductGet.fromJson(item));
          }
          return products.isNotEmpty
              ? futureData.first
              : null; // Return the first product or null if the list is empty
        } else {
          print('Unexpected data format: $data');
          return null;
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Future<ProductGet?> userGet(String token) async {
  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(
  //           'https://typescript-al0m.onrender.com/api/user/product/showall-product'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     print(response.statusCode);
  //     var data = jsonDecode(response.body);
  //     print(data);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       if (data is List) {
  //         for (var item in data) {
  //           print(item);
  //           futureData?.add(jsonDecode(response.body));
  //           return ProductGet.fromJson(item);
  //         }
  //       } else {
  //         print('Unexpected data format: $data');
  //         return null;
  //       }
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
}
