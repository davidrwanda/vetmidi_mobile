import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/routes/index.dart';

import '../core/utils/app_constants.dart';
import 'language_switch.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10 * fem),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const LanguageSwitch(),
          PopupMenuButton(
            color: Colors.white,
            onSelected: (int selected) async {
              if (selected == 0) {
                Get.find<AuthController>().selectedTab = 0;
              } else {
                Get.find<AuthController>().logout();
                Get.toNamed(AppRoutes.login);
              }
            },
            offset: const Offset(0, 40),
            child: Container(
              height: 40 * fem,
              width: 40 * fem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20 * fem)),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(221, 103, 183, 1.0),
                    Color.fromRGBO(233, 101, 190, 1.0),
                    Color.fromRGBO(193, 42, 144, 1.0),
                  ],
                  stops: [0.0001, 0.5365, 1.0],
                  // transform: GradientRotation(314.99 * 3.14159265 / 180.0),
                ),
              ),
              child: Center(
                  child: Text(
                "${Get.find<AuthController>().user?.firstName.substring(0, 1).toUpperCase()}${Get.find<AuthController>().user?.lastName.substring(0, 1).toUpperCase()}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16 * ffem,
                ),
              )),
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: Text("sidebar.profile".tr),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("topbar.logout".tr),
              ),
            ],
          ),
          SizedBox(width: 30 * fem),
        ],
      ),
    );
  }
}
