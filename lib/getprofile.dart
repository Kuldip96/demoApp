import 'dart:developer';

import 'package:demo_app/Models/profile_get.dart';
import 'package:demo_app/update_profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetProfileScreen extends StatefulWidget {
  const GetProfileScreen({super.key});

  @override
  _GetProfileScreenState createState() => _GetProfileScreenState();
}

class _GetProfileScreenState extends State<GetProfileScreen> {
  Future<GetProfile>? futureProfile;
  String? Token;
  String? name;
  @override
  void initState() {
    futureProfile = fetchProfile();
    super.initState();
  }

  Future<GetProfile> fetchProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString('token');

    log(Token.toString());
    final response = await http.get(
      Uri.parse('https://typescript-al0m.onrender.com/api/user/get-profile'),
      headers: {'Authorization': 'Bearer $Token'},
    );
    final data = jsonDecode(response.body);
    name = data['name'];
    log(name.toString());
    if (response.statusCode == 200) {
      log(response.body);
      return GetProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: FutureBuilder<GetProfile>(
                future: futureProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListTile(
                      title: Text(snapshot.data?.name.toString() ?? ""),
                      subtitle: Text(snapshot.data?.email.toString() ?? ""),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(
                      name: name!,
                    ),
                  ),
                );
              },
              child: const Text("Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
