import 'dart:developer';

import 'package:demo_app/Models/profile_get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  String? Token;
  @override
  void initState() {
    super.initState();
  }

  // Future<void> fetchProfile(String name) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Token = prefs.getString('token');
  //   log(name);
  //   log(Token.toString());
  //   final response = await http.put(
  //       Uri.parse(
  //           'https://typescript-al0m.onrender.com/api/user/update-profile'),
  //       headers: {'Authorization': 'Bearer $Token'},
  //       body: jsonEncode({
  //         'email': name,
  //       }));

  //   if (response.statusCode == 200) {
  //     log("updateed");
  //     log(response.body);
  //     //return GetProfile.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to load profile');
  //   }
  // }
  Future<void> fetchProfile(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final Uri uri = Uri.parse(
        'https://typescript-al0m.onrender.com/api/user/update-profile');
    final Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final Map<String, dynamic> bodyData = {'email': name};

    try {
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(bodyData),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        print(response.body);
      } else {
        throw Exception('Failed to update profile: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating profile: $error');
      throw Exception('Failed to update profile: $error');
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
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  fetchProfile(nameController.text);
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
