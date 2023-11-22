import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/controllers/patient_controller.dart';

import '../../components/pet_row_item.dart';
import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class PetsTableView extends StatefulWidget {
  const PetsTableView({super.key});

  @override
  State<PetsTableView> createState() => _PetsTableViewState();
}

class _PetsTableViewState extends State<PetsTableView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * fem),
      child: Column(
        children: [
          SizedBox(
            height: 460 * fem,
            width: double.infinity,
            // padding: EdgeInsets.all(20 * fem),
            child: RawScrollbar(
              thumbVisibility: true,
              thumbColor: ThemeColors.primaryColor,
              trackVisibility: true,
              trackColor: const Color(0xff1C2232),
              thickness: 10 * fem,
              radius: Radius.circular(20 * fem),
              interactive: true,
              controller: _scrollController,
              scrollbarOrientation: ScrollbarOrientation.bottom,
              child: Column(
                children: [
                  Container(
                    // color: Colors.amber,
                    width: double.infinity,
                    height: 60 * fem,
                    padding: EdgeInsets.all(12 * fem),
                    margin: EdgeInsets.symmetric(
                      vertical: 10 * fem,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      children: [
                        Container(
                          width: 80 * fem,
                          height: 50 * fem,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 60 * fem,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              "Nom",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60 * fem,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              "Race",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 90 * fem,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              "Date de naissance",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60 * fem,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              "Espece",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60 * fem,
                          height: double.infinity,
                          child: const Center(
                            child: Text(
                              "Sterilise",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          width: 40 * fem,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                        Container(
                          width: 40 * fem,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 370 * fem,
                    child: ListView(
                      children: [
                        ...Get.find<PatientController>()
                            .patients
                            .map((pet) => PetRowItem(patient: pet))
                            .toList()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
