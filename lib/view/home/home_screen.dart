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
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getToken();
   
    super.initState();
  }
  String Token="";
  Future getToken()async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
   Token= prefs.getString('token')!;
    fetchAlbum();
   log("Token $Token");
  }
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInScreen()));
  }

  Future<ShowProduct> fetchAlbum() async {
    log(Token);
    final response = await http.get(
      Uri.parse(
          'https://typescript-al0m.onrender.com/api/user/product/showall-product'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $Token',
      },
    );

    if (response.statusCode == 200) {
      return ShowProduct.fromJson(
          jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

   Future<ShowProduct>? futureData;
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
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<ShowProduct>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SecondScren(
                                            image: "images/Rectangle 391.png",
                                          )));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColor.primeryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: GlobleText(
                                  text: AppText.name,
                                  // color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColor.darkColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Text(AppText.name),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GlobleButton(onTap: () {}),
                    Container(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('data')))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
