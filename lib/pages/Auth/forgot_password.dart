import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/components/inputs.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/language_switch.dart';
import '../../core/utils/app_constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _email;
  var emailIsValid = true;
  var emailTextError = "";
  var rememberMe = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  Future<void> forgotPasswordHandler() async {
    if (validateInputs()) {
      await Get.find<AuthController>().forgotPassword(_email.text);
    }
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

    // if (_email.text.isNotEmpty && !validateEmail(_email.text)) {
    //   formIsValid = false;
    //   setState(() {
    //     emailTextError = "errors.form.email.required.valid".tr;
    //     emailIsValid = false;
    //   });
    //   Timer(const Duration(seconds: 2), () {
    //     setState(() {
    //       emailIsValid = true;
    //     });
    //   });
    // }
    return formIsValid;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 40 * fem, vertical: 20 * fem),
          child: ListView(
            children: [
              backButton(),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                height: 150 * fem,
                width: 150 * fem,
                child:
                    Image.asset("assets/images/logo.png", fit: BoxFit.contain),
              ),
              Text(
                "page.forgetPassSubTitle".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 15 * fem),
              Text(
                "page.forgetPassDescription".tr,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 35 * fem),
              InputText(
                "page.loginEmailPlaceholder".tr,
                _email,
                valid: emailIsValid,
                errorText: emailTextError,
              ),
              SizedBox(height: 10 * fem),
              Obx(() {
                return Button(
                  "page.sendRequest".tr,
                  (BuildContext ctx) async {
                    await forgotPasswordHandler();
                  },
                  context,
                  loading: Get.find<AuthController>().loading,
                );
              }),
              SizedBox(height: 20 * fem),
              SizedBox(height: 20 * fem),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.signup),
                child: Text("Don't have an account? Sign up",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black45)),
              ),
              SizedBox(height: 60 * fem),
              const LanguageSwitch(),
              SizedBox(height: 60 * fem),
              Text(
                "©${DateTime.now().year} Digimidi",
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
