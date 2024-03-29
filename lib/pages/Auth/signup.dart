import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/components/inputs.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
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
        body: ListView(
          children: [
            registerTopDesign(),
            SizedBox(height: 20 * fem),
            Container(
              padding: EdgeInsets.only(left: 20 * fem),
              child: Text(
                "User Verification",
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(height: 15 * fem),
            Padding(
              padding: EdgeInsets.only(left: 20 * fem),
              child: Text(
                "To ensure the security of your account, please, provide a 6-digit verification code, we have sent to your email address.",
              ),
            ),
            SizedBox(height: 35 * fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "First name",
                _firstName,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "Last name",
                _lastName,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "E-mail",
                _email,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: InputText(
                "Password",
                _password,
                isPassword: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * fem),
              child: Container(
                padding: EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 2),
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
                  IconButton(
                    onPressed: () =>
                        Get.to(SelectClinics(setClinic: (Clinic clinic) {
                      setState(() {
                        selectedClinic = clinic;
                      });
                    })),
                    icon: Icon(Icons.keyboard_arrow_right),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 30 * fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return Button(
                  "Proceed",
                  (BuildContext ctx) async {
                    if (selectedClinic != null) {
                      await Get.find<AuthController>().signup(
                        _firstName.text,
                        _lastName.text,
                        _email.text,
                        _password.text,
                        selectedClinic!.id.toString(),
                      );
                    }
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
