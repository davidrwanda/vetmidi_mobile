import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/components/inputs.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/core/utils/functions.dart';
import 'package:vetmidi/pages/Auth/select_clinic.dart';
import 'package:vetmidi/routes/index.dart';

import '../../components/register_top_design.dart';
import '../../core/utils/app_constants.dart';
import '../../models/clinic.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  var firstNameIsValid = true;
  var lastNameIsValid = true;
  var emailIsValid = true;
  var emailTextError = "";
  var passwordIsValid = true;
  var passwordTextError = "";
  Clinic? selectedClinic = null;
  var rememberMe = false;

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  bool validateInputs() {
    var formIsValid = true;
    if (_firstName.text.isEmpty) {
      formIsValid = false;
      setState(() {
        firstNameIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          firstNameIsValid = true;
        });
      });
    }
    if (_lastName.text.isEmpty) {
      formIsValid = false;
      setState(() {
        lastNameIsValid = false;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          lastNameIsValid = true;
        });
      });
    }
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

  signUpHandler() async {
    if (validateInputs()) {
      if (selectedClinic != null) {
        await Get.find<AuthController>().signup(
          _firstName.text,
          _lastName.text,
          _email.text,
          _password.text,
          selectedClinic!.id.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            registerTopDesign(),
            SizedBox(height: 20 * fem),
            Container(
              padding: EdgeInsets.only(left: 20 * fem),
              child: Text(
                "page.signInButton".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(height: 15 * fem),
            Padding(
              padding: EdgeInsets.only(left: 20 * fem),
              child: Text(
                "Provide your full name, email and select the clinic to securely sign in and access your account.",
              ),
            ),
            SizedBox(height: 25 * fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "First name",
                _firstName,
                valid: firstNameIsValid,
                errorText: "errors.form.firstName.required".tr,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * fem,
              ),
              child: InputText(
                "Last name",
                _lastName,
                valid: lastNameIsValid,
                errorText: "errors.form.secondName.required".tr,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * fem,
              ),
              child: InputText(
                "E-mail",
                _email,
                valid: emailIsValid,
                errorText: emailTextError,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "Password",
                _password,
                isPassword: true,
                valid: passwordIsValid,
                errorText: passwordTextError,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: GestureDetector(
                onTap: () => Get.to(SelectClinics(setClinic: (Clinic clinic) {
                  setState(() {
                    selectedClinic = clinic;
                  });
                })),
                child: Container(
                  padding: EdgeInsets.all(10 * fem),
                  decoration: BoxDecoration(
                    border: Border.all(color: ThemeColors.primaryGrey4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        selectedClinic == null
                            ? "Choose Clinic..."
                            : selectedClinic!.app_name,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          color: ThemeColors.textColor,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ]),
                ),
              ),
            ),
            SizedBox(height: 20 * fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return Button(
                  "Proceed",
                  (BuildContext ctx) async {
                    await signUpHandler();
                  },
                  context,
                  backgroundColor: selectedClinic == null
                      ? ThemeColors.secondaryColor.withOpacity(0.3)
                      : ThemeColors.secondaryColor,
                  loading: Get.find<AuthController>().loading,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
