import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/models/clinic.dart';
import 'package:vetmidi/models/config.dart';

class ClinicChangePopup extends StatelessWidget {
  final Config currentClinic;
  final Config newClinic;

  const ClinicChangePopup({
    Key? key,
    required this.currentClinic,
    required this.newClinic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Clinic"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Are you sure you want to change your clinic from:"),
          Text(currentClinic.appName,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("to:"),
          Text(newClinic.appName,
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Get.back(result: false),
        ),
        ElevatedButton(
          child: Text("Confirm"),
          onPressed: () => Get.back(result: true),
        ),
      ],
    );
  }
}

