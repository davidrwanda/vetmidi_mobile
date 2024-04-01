import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/components/inputs.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/language_switch.dart';
import '../../core/utils/app_constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  var rememberMe = false;

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
              ),
              InputText(
                "page.loginPswPlaceholder".tr,
                _password,
                isPassword: true,
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
                        await Get.find<AuthController>()
                            .login(_email.text, _password.text);
                      },
                      context,
                      loading: Get.find<AuthController>().loading,
                    );
                  })
                ],
              ),
              SizedBox(height: 20 * fem),
              Text(
                "page.signInForgotPass".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black45),
              ),
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
