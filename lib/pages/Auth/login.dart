import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/components/inputs.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/language_switch.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  var rememberMe = false;
  var emailIsValid = true;
  var passwordIsValid = true;
  var emailTextError = "";
  var passwordTextError = "";

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: Text("Yes, It is"),
      onPressed: () => Navigator.pop(context),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("New device detected"),
      content: Text("Please confirm that this is this your new device?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool validateInputs() {
    var formIsValid = true;
    if (_email.text.isEmpty) {
      formIsValid = false;
      setState(() {
        emailTextError = "errors.form.email.required".tr;
        emailIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          emailIsValid = true;
        });
      });
    }

    if (_email.text.isNotEmpty && !validateEmail(_email.text)) {
      formIsValid = false;
      setState(() {
        emailTextError = "errors.form.email.required.valid".tr;
        emailIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          emailIsValid = true;
        });
      });
    }

    if (_password.text.isEmpty) {
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
    if (_password.text.isNotEmpty && !validatePassword(_password.text)) {
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
    return formIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20 * fem),
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
              Text(
                "page.loginWelcome".tr,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 15 * fem),
              Text("page.loginSubtext".tr, textAlign: TextAlign.center),
              SizedBox(height: 35 * fem),
              InputText(
                "page.loginEmailPlaceholder".tr,
                _email,
                valid: emailIsValid,
                errorText: emailTextError,
              ),
              InputText(
                "page.loginPswPlaceholder".tr,
                _password,
                isPassword: true,
                valid: passwordIsValid,
                errorText: passwordTextError,
              ),
              SizedBox(height: 10 * fem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: rememberMe,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                rememberMe = newValue;
                              });
                            }
                          }),
                      Text("page.signInRememberMe".tr),
                    ],
                  ),
                  Obx(() {
                    return Button(
                      "page.LoginNow".tr,
                      (BuildContext ctx) async {
                        Get.find<AuthController>().selectedTab = 0;
                        if (validateInputs()) {
                          await Get.find<AuthController>()
                              .login(_email.text, _password.text);
                        }
                      },
                      context,
                      loading: Get.find<AuthController>().loading,
                    );
                  })
                ],
              ),
              SizedBox(height: 5 * fem),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                child: Text("page.signInForgotPass".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black45)),
              ),
              SizedBox(height: 5 * fem),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.signup),
                child: Text("Don't have an account? Sign up",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black45)),
              ),
              SizedBox(height: 40 * fem),
              const LanguageSwitch(),
              SizedBox(height: 40 * fem),
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
