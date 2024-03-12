import 'dart:developer';
import 'package:demo_app/Models/profile_get.dart';
import 'package:demo_app/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final box = GetStorage();
  @override
  void initState() {
    futureProfile = fetchProfile();
    super.initState();
  }

  _getRequests() async {
    setState(() {});
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
    box.write('name', data['name']);
    log(name.toString());
    if (response.statusCode == 200) {
      log(response.body);
      Get.snackbar('Message', 'Load data.....!',
          backgroundColor: Colors.yellow,
          icon: Icon(Icons.abc),
          snackPosition: SnackPosition.BOTTOM);
      Get.defaultDialog(
        actions: [],
        title: 'text',
      );
      return GetProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  // Future<void> delateProfile() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Token = prefs.getString('token');

  //   log(Token.toString());
  //   final response = await http.delete(
  //     Uri.parse('https://typescript-al0m.onrender.com/api/user/delete-profile'),
  //     headers: {'Authorization': 'Bearer $Token'},
  //   );

  //   log(response.body);
  //   if (response.statusCode == 200) {
  //     log(response.body);

  //     prefs.remove('token');
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (_) => const SignInScreen()),
  //         (route) => false);
  //   } else {
  //     throw Exception('Failed to load profile');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //delateProfile();
            },
            icon: Icon(Icons.delete_sharp),
          ),
        ],
      ),
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
                      name: box.read('name'),
                    ),
                  ),
                );
              },
              child: const Text("Update Profile"),
            ),
            ElevatedButton(
              onPressed: () {
                signInGooglr();
              },
              child: const Text('Google'),
            ),
          ],
        ),
      ),
    );
  }

  signInGooglr() async {
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleauth = await googleuser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleauth?.accessToken,
      idToken: googleauth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
