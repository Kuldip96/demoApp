import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:demo_app/Models/profile_get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<GetProfile> fetchProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('https://typescript-al0m.onrender.com/api/user/get-profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return GetProfile.fromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
