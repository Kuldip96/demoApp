import 'dart:developer';

import 'package:demo_app/Models/profile_get.dart';
import 'package:demo_app/service/api_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var userProfile = <GetProfile>[].obs;

  fatchProfile() async {
    try {
      isLoading(true);

      var userData = await ApiService().fetchProfile();

      userProfile.addAll(userData as Iterable<GetProfile>);
    } catch (e) {
      log('Error data $e');
    } finally {
      isLoading(false);
    }
  }
}
