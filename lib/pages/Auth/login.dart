import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _getRememberMePreference();
    _autoLoginIfDataExists();
  }

  _getRememberMePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        _email.text = prefs.getString('email') ?? '';
        _password.text = prefs.getString('password') ?? '';
      }
    });
  }

  _saveRememberMePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
    if (!value) {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  _autoLoginIfDataExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    int? expire_in = prefs.getInt('expire_in');

    try{
      if (email != null && password != null && expire_in != null) {
      if(DateTime.now().microsecondsSinceEpoch < expire_in){
        setState(() {
          _isLoading = true;
        });
        await Get.find<AuthController>().login(email, password);
        setState(() {
          _isLoading = false;
        });
      }
    }
    }
    catch(e){
      print(e.toString());
      _isLoading = false;
    }
  }

  _saveLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email.text);
    prefs.setString('password', _password.text);
    prefs.setInt('expire_in', DateTime.now().microsecondsSinceEpoch+172800000);
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
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20 * fem),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                    height: 150 * fem,
                    width: 150 * fem,
                    child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
                  ),
                  Text(
                    "page.loginWelcome".tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
                            activeColor: Colors.blue,
                            onChanged: (newValue) {
                              if (newValue != null) {
                                setState(() {
                                  rememberMe = newValue;
                                  _saveRememberMePreference(newValue);
                                });
                              }
                            },
                          ),
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
                              if (rememberMe) {
                                _saveLoginData();
                              }
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
                    child: Text(
                      "page.signInForgotPass".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                  SizedBox(height: 5 * fem),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    child: Text(
                      "page.signupText".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black45),
                    ),
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
            _isLoading
                ? Container(
                    color: Colors.black54,  // Background color to overlay
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 6.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Loader color
                      ),
                    ),
                  )
                : SizedBox.shrink(), // Empty widget when not loading
          ],
        ),
      ),
    );
  }
}
