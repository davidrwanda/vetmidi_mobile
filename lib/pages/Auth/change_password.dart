import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../components/inputs.dart';
import '../../core/utils/app_constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _currentPassword;
  late TextEditingController _newPassword;
  late TextEditingController _comfirmPassword;
  var oldPasswordIsValid = true;
  var newPasswordIsValid = true;
  var confirmPasswordIsValid = true;

  @override
  void initState() {
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _comfirmPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.primaryBackground,
        body: Padding(
          padding: EdgeInsets.all(30 * fem),
          child: Container(
            child: ListView(
              children: [
                backButton(),
                SizedBox(height: 20 * fem),
                Text(
                  "CHANGE PASSWORD",
                  style: TextStyle(
                      color: ThemeColors.secondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 30 * ffem),
                ),
                SizedBox(height: 50 * fem),
                InputText(
                  "",
                  _currentPassword,
                  label: "Current Password",
                  required: true,
                  valid: oldPasswordIsValid,
                  errorText: "Current Password is required",
                  isPassword: true,
                  setValid: (bool value) {
                    setState(() {
                      oldPasswordIsValid = value;
                    });
                  },
                ),
                InputText(
                  "",
                  _newPassword,
                  label: "New Password",
                  isPassword: true,
                  required: true,
                  valid: newPasswordIsValid,
                  errorText: "New Password is required",
                  setValid: (bool value) {
                    setState(() {
                      newPasswordIsValid = value;
                    });
                  },
                ),
                InputText(
                  "",
                  _comfirmPassword,
                  label: "Password Confirmation",
                  required: true,
                  isPassword: true,
                  valid: confirmPasswordIsValid,
                  errorText: "Password Confirmation is required",
                  setValid: (bool value) {
                    setState(() {
                      confirmPasswordIsValid = value;
                    });
                  },
                ),
                SizedBox(height: 50 * fem),
                Center(
                  child: Obx(() {
                    return Button(
                      "Change",
                      (context) {
                        String? email = Get.find<AuthController>().user!.email;
                        Get.find<AuthController>().changePassword(
                            email,
                            _currentPassword.text,
                            _newPassword.text,
                            _comfirmPassword.text);
                      },
                      context,
                      loading: Get.find<AuthController>().loading,
                      color: Colors.white,
                      backgroundColor: ThemeColors.primaryColor,
                      width: 200 * fem,
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
