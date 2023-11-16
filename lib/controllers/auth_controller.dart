import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/models/token.dart';
import 'package:vetmidi/routes/index.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxInt _selectedTab = 0.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final Rx<Token?> _token = Rx<Token?>(null);

  final AuthService _authService = AuthService();

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
    try {
      _isLoading.value = true;
      Map<String, String> map = {"email": email, "password": password};
      var res = await _authService.login(map);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        Token token = Token.fromJSON(res["token"]);
        _token.value = token;
        User user = User.fromJSON(res["user"]);
        _user.value = user;
        Get.toNamed(AppRoutes.home);
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    _token.value = null;
    _user.value = null;
  }
}
