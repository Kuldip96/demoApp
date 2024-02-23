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
  Future<List<TmdbModel>>? movie;
  @override
  void initState() {
    movie = _fetchData();
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
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final movieeee = snapshot.data;
            return ListView.builder(
              itemCount: movieeee?.length,
              itemBuilder: (context, index) {
                final data = movieeee?[index];
                return ListTile(
                  // title: Text(key),
                  subtitle: Text(data?.collection?.item?[index].name ?? "dw"),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<TmdbModel>> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://api.postman.com/collections/28250023-429979bf-5000-4f03-a37b-24f833fcb9ad?access_key=PMAT-01HFR95CTR0JXXS7G3S5P5E8WV'));

    if (response.statusCode == 200) {
      final List<TmdbModel> data = json.decode(response.body)['collection'];

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
