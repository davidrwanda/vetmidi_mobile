import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/models/notification.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../routes/index.dart';

class AppointmentCardItem extends StatelessWidget {
  const AppointmentCardItem({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  final NotificationModel appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 15 * fem,
                width: 15 * fem,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/calendar.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              Container(
                height: 20 * fem,
                width: 20 * fem,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/luna.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8 * fem),
              Text("Luna"),
            ],
          ),
          SizedBox(height: 9 * fem),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DATE",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Sep, 12, Thursday",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10 * fem),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TIME",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "13:00",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.appointmentdetails),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Details"),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: ThemeColors.secondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
