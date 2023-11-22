import 'package:get/get.dart';
import 'package:vetmidi/components/toast.dart';
import 'package:vetmidi/services/profile_service.dart';

import '../models/profile.dart';

class ProfileController extends GetxController {
  final RxBool _fetching = false.obs;
  final RxBool _updating = false.obs;
  final RxBool _fetchedProfile = false.obs;
  final Rx<Profile?> _profile = Rx<Profile?>(null);
  final ProfileService _profileService = ProfileService();

  bool get fetchedProfile {
    return _fetchedProfile.value;
  }

  set fetchedProfile(bool value) {
    _fetchedProfile.value = value;
  }

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

  Future<void> getProfile(String token) async {
    try {
      _fetching.value = true;
      var res = await _profileService.getProfileService(token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        _profile.value = Profile.fromJSON(res["data"]);
        _fetchedProfile.value = true;
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _fetching.value = false;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> body, String token) async {
    try {
      _updating.value = true;
      var res = await _profileService.updatePatientService(body, token);
      if (res["error"] != null && res["error"] == true) {
        throw Exception(res["message"]);
      } else {
        showToast("page.profile.updateSuccessful".tr,
            title: "feedback.alert.successTitle".tr);
      }
    } catch (error) {
      showToast(error.toString());
    } finally {
      _updating.value = false;
    }
  }
}
