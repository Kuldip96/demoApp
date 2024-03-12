import 'package:demo_app/Models/profile_get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Import your GetProfile model

class ProfileController extends GetxController {
  var profile = GetProfile().obs;
  Future<GetProfile>? futureProfile;
  Future<void> fetchProfile() async {
    try {
      var response = await http.get(Uri.parse(
          'https://typescript-al0m.onrender.com/api/user/get-profile'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        profile.value = GetProfile.fromJson(data);
        // futureProfile=GetProfile.f
      } else {
        // Handle error
        print('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Exception while loading profile: $e');
    }
  }
}
