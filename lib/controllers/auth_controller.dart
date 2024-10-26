import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetmidi/core/utils/toast.dart';
import 'package:vetmidi/models/clinic.dart';
import 'package:vetmidi/models/token.dart';
import 'package:vetmidi/routes/index.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';

class AuthController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _resendingOtp = false.obs;
  final RxInt _selectedTab = 0.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final RxList<Clinic?> _clinics = RxList<Clinic?>([]);
  final RxList<Clinic?> _selectedClinics = RxList<Clinic?>([]);
  final Rx<Token?> _token = Rx<Token?>(null);
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  bool get loading {
    return _isLoading.value;
  }

  bool get resendingOTP {
    return _resendingOtp.value;
  }

  List<Clinic?> get clinics {
    return [..._selectedClinics];
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

  void searchClinic(String query) {
    List<Clinic?> results = _clinics
        .where((clinic) =>
            clinic!.app_name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    _selectedClinics.value = results;
  }

  void resetClinics() {
    _selectedClinics.value = _clinics;
  }

  Future<T> _retryOperation<T>(Future<T> Function() operation, {int maxRetries = 3}) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await operation();
      } catch (error) {
        if (attempt == maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 1 * attempt));
      }
    }
    throw Exception('Operation failed after $maxRetries attempts');
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      await _retryOperation(() async {
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
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signup(String firstName, String lastName, String email,
      String password, String clinicID) async {
    try {
      _isLoading.value = true;
      await _retryOperation(() async {
        Map<String, String> map = {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
          "password_confirmation": password,
          "clinic": clinicID
        };
        var res1 = await _authService.signupService(map);
        if (res1["error"] != null && res1["error"] == true) {
          throw Exception(res1["message"]);
        } else {
          Map<String, String> loginMap = {"email": email, "password": password};
          var res2 = await _authService.login(loginMap);
          Token token = Token.fromJSON(res2["token"]);
          _token.value = token;
          User user = User.fromJSON(res2["user"]);
          _user.value = user;
          Get.toNamed(AppRoutes.verifyOTP, arguments: email);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> verifyOTP(String email, String otp) async {
    try {
      _isLoading.value = true;
      await _retryOperation(() async {
        Map<String, String> map = {
          "email": email,
          "otp": otp,
        };
        var res1 = await _authService.verifyOTPService(map);
        if (res1["code"] != null && res1["code"] == 422) {
          List<dynamic> errors = res1["errors"];
          throw Exception(errors[0]["message"]);
        } else {
          successToast("page.verify.succeed".tr);
          Get.toNamed(AppRoutes.login, arguments: Get.arguments);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> resendOTP(String email) async {
    try {
      _resendingOtp.value = true;
      await _retryOperation(() async {
        Map<String, String> map = {
          "email": email,
        };
        var res1 = await _authService.resendOTPService(map);
        if (res1["code"] != null && res1["code"] == 422) {
          List<dynamic> errors = res1["errors"];
          throw Exception(errors[0]["message"]);
        } else {
          successToast(res1["message"]);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _resendingOtp.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      _isLoading.value = true;
      Map<String, String> map = {
        "email": email,
      };
      var res1 = await _authService.forgotPasswordService(map);
      if (res1["code"] != null && res1["code"] == 422) {
        List<dynamic> errors = res1["errors"];
        errorToast(errors[0]["message"]);
      } else {
        successToast("page.verify.otpsent".tr);
        Get.toNamed(AppRoutes.resetPassword, arguments: {"email": email});
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email, String password, String otp) async {
    try {
      _isLoading.value = true;
      Map<String, String> map = {
        "email": email,
        "password": password,
        "otp": otp,
      };
      var res1 = await _authService.resetPasswordService(map);
      if (res1["code"] != null && res1["code"] == 422) {
        List<dynamic> errors = res1["errors"];
        errorToast(errors[0]["message"]);
      } else {
        successToast("page.verify.password-changed".tr);
        Get.toNamed(AppRoutes.login);
      }
    } catch (error) {
      successToast(error.toString());
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
      "last_name": _user.value?.lastName,
      "mobile_device": newDeviceId
    };
    await _profileService.updatePatientService(body, _token.value!.accessToken);
    var userJson = _user.value!.toJson();
    userJson["mobile_device"] = newDeviceId;
    User newUser = User.fromJSONCustom(userJson);
    _user.value = newUser;
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
        errorToast(res["message"]);
      } else {
        successToast("page.verify.password-changed".tr);
        Timer(const Duration(seconds: 2), () {
          Get.toNamed(AppRoutes.login);
          _selectedTab.value = 0;
        });
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> getClinics() async {
    try {
      _isLoading.value = true;
      var res = await _authService.getClinicsService();
      if (res["error"] != null && res["error"] == true) {
        errorToast(res["message"]);
      } else {
        List<dynamic> data = res["data"];
        _clinics.value = data.map((e) => Clinic.fromJSON(e)).toList();
        _selectedClinics.value = [..._clinics];
      }
    } catch (error) {
      successToast(error.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _retryOperation(() async {
        // Implement logout API call if there's one
        _token.value = null;
        _user.value = null;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('expire_in');
      });
      print("Logged out");
    } catch (error) {
      errorToast(error.toString());
    }
  }
}
