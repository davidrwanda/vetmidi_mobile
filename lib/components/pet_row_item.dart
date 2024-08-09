import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/patient_controller.dart';
import '../core/theme/colors_theme.dart';
import '../core/utils/app_constants.dart';
import '../models/patients.dart';
import '../routes/index.dart';

class PetRowItem extends StatefulWidget {
  const PetRowItem({
    Key? key,
    required this.patient,
  }) : super(key: key);

  final Patient patient;

  @override
  State<PetRowItem> createState() => _PetRowItemState();
}

class _PetRowItemState extends State<PetRowItem> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 70 * fem,
      padding: EdgeInsets.all(12 * fem),
      margin: EdgeInsets.symmetric(
        vertical: 10 * fem,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: [
          SizedBox(
            width: 60 * fem,
            height: 50 * fem,
            child: Center(
              child: Container(
                height: 50 * fem,
                width: 50 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25 * fem),
                ),
                child: ClipOval(
                  child: widget.patient.webImage.isEmpty
                      ? Image.asset(
                          "assets/images/dog.png",
                        )
                      : Image.network(
                          widget.patient.webImage,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80 * fem,
            height: double.infinity,
            child: Center(
              child: Text(
                widget.patient.name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // SizedBox(
          //   width: 60 * fem,
          //   height: double.infinity,
          //   child: Center(
          //     child: Text(
          //       widget.patient.race,
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 100 * fem,
            height: double.infinity,
            child: Center(
              child: Text(
                widget.patient.birthDate,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // SizedBox(
          //   width: 60 * fem,
          //   height: double.infinity,
          //   child: Center(
          //     child: Text(
          //       "page.type.${widget.patient.species}".tr,
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 70 * fem,
          //   height: double.infinity,
          //   child: Row(
          //     children: [
          //       getTranslationKeys(widget.patient.sterilise.toLowerCase()) ==
          //               "page.general.yes"
          //           ? const Icon(
          //               Icons.check_circle_outline,
          //               color: ThemeColors.secondaryColor,
          //               size: 18,
          //             )
          //           : Icon(
          //               Icons.highlight_off,
          //               color: ThemeColors.deleteRed2.withOpacity(0.6),
          //               size: 18,
          //             ),
          //       SizedBox(width: 4 * fem),
          //       Text(
          //         getTranslationKeys(widget.patient.sterilise.toLowerCase()).tr,
          //         style: const TextStyle(color: Colors.black38),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            width: 40 * fem,
            height: double.infinity,
            child: GestureDetector(
              onTap: () {
                Get.find<PatientController>().patient = widget.patient;
                Get.toNamed(AppRoutes.editpetdetails);
              },
              child: Center(
                child: Image.asset("assets/images/edit.png"),
              ),
            ),
          ),
          SizedBox(
            width: 40 * fem,
            height: double.infinity,
            child: Center(
              child: IconButton(
                  onPressed: () {
                    Get.find<PatientController>().patient = widget.patient;
                    Get.toNamed(AppRoutes.petdetails);
                  },
                  icon: const Icon(
                    Icons.preview,
                    color: ThemeColors.secondaryColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
