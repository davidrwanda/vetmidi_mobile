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
  final Rx<String?> _fCMToken = Rx<String?>(null);

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

  String? get fCMToken {
    return _fCMToken.value;
  }

  set fCMToken(String? value) {
    _fCMToken.value = value;
    final box = GetStorage();
    box.write('fCMToken', value);
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      Map<String, String> map = {"email": email, "password": password};
      var res = await _authService.login(map);
      var res2 = await _authService.login(map);
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
      final box = GetStorage();
      String? fcm = await box.read('fCMToken');
      var body = {
        "email": email,
        "first_name": user?.firstName,
        "last_name": user?.lastName,
        "mobile_device": fcm
      };
      print("updating profile with device id $body");
      var res = await _profileService.updatePatientService(
          body, _token.value!.accessToken);
      print("done eeee e eupdating profile with device id $res");
    }
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
