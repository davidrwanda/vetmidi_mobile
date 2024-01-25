import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/controllers/profile_controller.dart';
import 'package:vetmidi/models/token.dart';
import 'package:vetmidi/routes/index.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';

class AuthController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxInt _selectedTab = 0.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<Token?> _token = Rx<Token?>(null);

  final ProfileController _profileController = ProfileController();
  final PatientController _petController = PatientController();
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  bool get loading {
    return _isLoading.value;
  }

  User? get user {
    return _user.value;
  }

  Token? get token {
    return _token.value;
  }

  int get selectedTab {
    return _selectedTab.value;
  }

  set selectedTab(int value) {
    _selectedTab.value = value;
  }

  Future<void> login(String email, String password) async {
    var res2 = null;
    try {
      _isLoading.value = true;
      Map<String, String> map = {"email": email, "password": password};
      var res = await _authService.login(map);
      res2 = await _authService.login(map);
      if (res2["error"] != null && res2["error"] == true) {
        throw Exception(res2["message"]);
      } else {
        Token token = Token.fromJSON(res2["token"]);
        _token.value = token;
        User user = User.fromJSON(res2["user"]);
        _user.value = user;
        Get.toNamed(AppRoutes.home);
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> updateDeviceId(String newDeviceId) async {
    final box = GetStorage();
    box.write('fCMToken', newDeviceId);
    var body = {
      "email": _user.value?.email,
      "first_name": _user.value?.firstName,
      "last_name": _user.value?.firstName,
      "mobile_device": newDeviceId
    };
    var res = await _profileService.updatePatientService(
        body, _token.value!.accessToken);
    var userJson = _user.value!.toJson();
    userJson["mobile_device"] = newDeviceId;
    User newUser = User.fromJSONCustom(userJson);
    // print("new user Json $newUser");
    _user.value = newUser;
    // print("ressssssss $res");
  }

  Future<void> changePassword(String email, String currentPassword,
      String password, String passwordConfirmation) async {
    try {
      _isLoading.value = true;
      Map<String, String> map = {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "current_password": currentPassword,
      };
      var res = await _authService.changePasswordScreen(
          map, _token.value!.accessToken);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        showToast("Password updated successfully!", title: "Success");
        Timer(const Duration(seconds: 2), () {
          Get.toNamed(AppRoutes.login);
          _selectedTab.value = 0;
        });
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    _selectedTab.value = 0;
    _token.value = null;
    _user.value = null;
  }
}
