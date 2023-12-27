import 'package:flutter/material.dart';
import 'package:vetmidi/components/back_button.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../../core/utils/app_constants.dart';

class TreatmentDetails extends StatelessWidget {
  const TreatmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ThemeColors.primaryBackground,
      body: Padding(
        padding: EdgeInsets.all(20 * fem),
        child: ListView(
          children: [
            backButton(),
            SizedBox(height: 10 * fem),
            Text(
              "Treatment #5321",
              style: TextStyle(
                fontSize: 33 * ffem,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15 * fem),
            Container(
              padding: EdgeInsets.all(20 * fem),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10 * fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Pet Name")),
                        Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Container(
                                  height: 35 * fem,
                                  width: 35 * fem,
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/luna.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5 * fem),
                                Text("Luna"),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Starting Date")),
                        Expanded(flex: 5, child: Text("12 Sep, 2023")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Ending Date")),
                        Expanded(flex: 5, child: Text("12 Sep, 2023")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Renewal")),
                        Expanded(flex: 5, child: Text("Yes")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Text(
                    "POSOLOGY #1",
                    style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10 * fem),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Medecine Name")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Posology")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Instructions")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Text(
                    "POSOLOGY #2",
                    style: TextStyle(
                      color: Colors.black12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10 * fem),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Medecine Name")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Posology")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7 * fem),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Instructions")),
                        Expanded(flex: 5, child: Text("-")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  Button(
                    "Dial Clinic",
                    (context) {},
                    context,
                    backgroundColor: Colors.white,
                    hasBorder: true,
                    color: ThemeColors.secondaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
