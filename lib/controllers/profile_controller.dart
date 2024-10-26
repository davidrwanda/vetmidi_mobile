import 'package:get/get.dart';
import 'package:vetmidi/core/utils/toast.dart';
import 'package:vetmidi/models/config.dart';
import 'package:vetmidi/services/profile_service.dart';

import '../models/profile.dart';

class ProfileController extends GetxController {
  final RxBool _fetching = false.obs;
  final RxBool _updating = false.obs;
  final Rx<Profile?> _profile = Rx<Profile?>(null);
  final ProfileService _profileService = ProfileService();

  bool get fetching {
    return _fetching.value;
  }

  bool get updating {
    return _updating.value;
  }

  Profile? get profile {
    return _profile.value;
  }

  set profile(Profile? inProfile) {
    _profile.value = inProfile;
  }

  void resetProfileState() {
    _profile.value = null;
  }

  final Rx<Config> _currentClinic = Rx<Config>(Config(id: 0, address: "", phone: "", appName: ""));

  Config get currentClinic => _currentClinic.value;

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

  Future<void> getProfile(String token) async {
    try {
      _fetching.value = true;
      await _retryOperation(() async {
        var res = await _profileService.getProfileService(token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          _profile.value = Profile.fromJSON(res["data"]);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> body, String token) async {
    try {
      _updating.value = true;
      await _retryOperation(() async {
        var res = await _profileService.updatePatientService(body, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          successToast("page.profile.updateSuccessful".tr);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _updating.value = false;
    }
  }

  Future<void> changeClinic(Map<String, dynamic> body, String token) async {
    try {
      _updating.value = true;
      await _retryOperation(() async {
        var res = await _profileService.changeClinicService(body, token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          successToast("page.profile.updateSuccessful".tr);
        }
      });
    } catch (error) {
      errorToast(error.toString());
    } finally {
      _updating.value = false;
    }
  }

  Future<List<Config>> getClinicsConfig(String token) async {
    try {
      return await _retryOperation(() async {
        var res = await _profileService.getClinicsConfigService(token);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          return List<Config>.from(
              res["data"].map((config) => Config.fromJson(config)));
        }
      });
    } catch (error) {
      errorToast(error.toString());
      return [];
    }
  }

  Future<Config> getClinicConfig(String token, String configId) async {
    try {
      return await _retryOperation(() async {
        var res = await _profileService.getClinicConfigService(token, configId);
        if (res["error"] != null && res["error"] == true) {
          throw Exception(res["message"]);
        } else {
          return Config.fromJson(res["data"]);
        }
      });
    } catch (error) {
      errorToast(error.toString());
      return Config(id: 0, address: "", phone: "", appName: "");
    }
  }

}
