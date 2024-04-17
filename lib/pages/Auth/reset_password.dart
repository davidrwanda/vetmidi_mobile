import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/auth_controller.dart';

import '../../components/inputs.dart';
import '../../components/language_switch.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/functions.dart';
import '../../routes/index.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _newPassword;
  late TextEditingController _comfirmPassword;
  late TextEditingController _otp;
  var passwordIsValid = true;
  var confirmPasswordIsValid = true;
  var otpIsValid = true;
  var passwordTextError = "";
  var passwordConfirmationTextError = "";

  @override
  void initState() {
    _newPassword = TextEditingController();
    _comfirmPassword = TextEditingController();
    _otp = TextEditingController();
    super.initState();
  }

  Future<void> resetPasswordHandler(String email) async {
    if (validateInputs()) {
      await Get.find<AuthController>()
          .resetPassword(email, _newPassword.text, _otp.text);
    }
  }

  bool validateInputs() {
    var formIsValid = true;
    if (_newPassword.text.isEmpty) {
      formIsValid = false;
      setState(() {
        passwordTextError = "errors.form.password.required".tr;
        passwordIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          passwordIsValid = true;
        });
      });
    }
    if (_newPassword.text.isNotEmpty && !validatePassword(_newPassword.text)) {
      formIsValid = false;
      setState(() {
        passwordTextError = "errors.form.password.required.valid".tr;
        passwordIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          passwordIsValid = true;
        });
      });
    }
    if (_comfirmPassword.text.isEmpty) {
      formIsValid = false;
      setState(() {
        passwordConfirmationTextError =
            "page.profile.confirmPassword.required".tr;
        confirmPasswordIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          confirmPasswordIsValid = true;
        });
      });
    }
    if (_comfirmPassword.text.isEmpty) {
      formIsValid = false;
      setState(() {
        passwordConfirmationTextError = "errors.form.password.required".tr;
        confirmPasswordIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          confirmPasswordIsValid = true;
        });
      });
    }
    if (_comfirmPassword.text.isNotEmpty &&
        _newPassword.text.isNotEmpty &&
        _comfirmPassword.text != _newPassword.text) {
      formIsValid = false;
      setState(() {
        passwordConfirmationTextError = "Passwords do not match".tr;
        confirmPasswordIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          confirmPasswordIsValid = true;
        });
      });
    }

    if (_otp.text.isEmpty) {
      formIsValid = false;
      setState(() {
        otpIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          otpIsValid = true;
        });
      });
    }
    return formIsValid;
  }

  @override
  Widget build(BuildContext context) {
    var email = Get.arguments["email"];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 30 * fem, vertical: 20 * fem),
          child: ListView(
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                height: 150 * fem,
                width: 150 * fem,
                child:
                    Image.asset("assets/images/logo.png", fit: BoxFit.contain),
              ),
              SizedBox(height: 15 * fem),
              Text(
                "message.form.resetPassword".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 35 * fem),
              InputText(
                "page.profile.password.required".tr,
                _newPassword,
                label: "",
                isPassword: true,
                valid: passwordIsValid,
                errorText: passwordTextError,
                setValid: (bool value) {
                  setState(() {
                    passwordIsValid = value;
                  });
                },
              ),
              InputText(
                "page.signUpPasswordConfirmPlaceholder".tr,
                _comfirmPassword,
                label: "",
                isPassword: true,
                valid: confirmPasswordIsValid,
                errorText: passwordConfirmationTextError,
                setValid: (bool value) {
                  setState(() {
                    confirmPasswordIsValid = value;
                  });
                },
              ),
              InputText(
                "OTP Verification Code",
                _otp,
                label: "",
                errorText: "OTP code is required",
                valid: otpIsValid,
              ),
              SizedBox(height: 10 * fem),
              Obx(() {
                return Button(
                  "page.resetPassSave".tr,
                  (BuildContext ctx) async {
                    await resetPasswordHandler(email);
                  },
                  context,
                  loading: Get.find<AuthController>().loading,
                );
              }),
              SizedBox(height: 100 * fem),
              const LanguageSwitch(),
              SizedBox(height: 60 * fem),
              const Text(
                "©2023 Digimidi",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
