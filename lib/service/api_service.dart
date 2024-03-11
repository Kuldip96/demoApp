import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:demo_app/Models/profile_get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String? Token;
  String? name;
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
}
