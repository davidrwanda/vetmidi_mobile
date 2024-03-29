import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../components/button.dart';
import '../../components/register_top_design.dart';
import '../../controllers/auth_controller.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  @override
  Widget build(BuildContext context) {
    final email = Get.arguments;
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
            OtpTextField(
              numberOfFields: 6,
              borderColor: ThemeColors.primaryGrey3,
              focusedBorderColor: Colors.grey,
              fieldWidth: 48 * fem,
              cursorColor: ThemeColors.textColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                Get.find<AuthController>().verifyOTP(email, verificationCode);
              }, // end onSubmit
            ),
            SizedBox(height: 230 * fem),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Resend Code?",
                  style: TextStyle(
                    color: ThemeColors.textColor,
                  ),
                )),
            SizedBox(height: 20 * fem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                  return Button(
                    "Proceed",
                    (BuildContext ctx) async {
                      // showAlertDialog(ctx);
                      // Get.toNamed(AppRoutes.profile);
                      // await Get.find<AuthController>()
                      //     .login(_email.text, _password.text);
                      // Get.toNamed(AppRoutes.verifyOTP);
                    },
                    context,
                    backgroundColor: ThemeColors.secondaryColor,
                    loading: Get.find<AuthController>().loading,
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
