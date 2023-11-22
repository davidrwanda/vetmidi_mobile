import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vetmidi/components/button.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/controllers/patient_controller.dart';
import 'package:vetmidi/core/utils/functions.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';
import '../../routes/index.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  List<PlatformFile> files = [];
  var uploaded = false;

  setUploaded(bool value) {
    setState(() {
      uploaded = value;
    });

    if (value) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(AppRoutes.home);
      });
    }
  }

  _removeFile(String name) {
    files.retainWhere((file) => file.name != name);
    setState(() {
      files = files;
    });
  }

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx'
        ], // Specify the allowed file types
      );

      if (result != null) {
        // Handle the picked file, e.g., upload it
        // print('File picked: ${result.files}');
        setState(() {
          files = [...files, ...result.files];
        });
        // print('File picked: ${result.files.first.name}');
      } else {
        // User canceled the file picker
        // print('File picking canceled');
      }
    } catch (e) {
      // Handle errors
      // print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return files.isEmpty
        ? Container(
            height: 300 * fem,
            padding: EdgeInsets.all(20 * fem),
            color: ThemeColors.primaryBackground,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickDocument,
                  child: RichText(
                    text: TextSpan(
                      text: "page.pets.uploadDescription".tr,
                      style: TextStyle(
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "page.pets.uploadBrowse".tr,
                          style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w800,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Obx(() {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColors.primaryGrey4),
                borderRadius: BorderRadius.circular(10 * fem),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  files = [];
                                });
                              },
                              child: Text("page.pet.cancel".tr)),
                          Text("${files.length} files selected"),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10 * fem),
                            margin: EdgeInsets.only(left: 5 * fem),
                            child: IconButton(
                              onPressed: _pickDocument,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ]),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: ThemeColors.primaryBackground,
                        border: Border(
                          top: BorderSide(
                            color: ThemeColors.primaryGrey4,
                          ),
                        )),
                    child: Column(
                      children: [
                        ...files
                            .map(
                              (file) => Container(
                                padding: EdgeInsets.all(10 * fem),
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: ThemeColors.primaryGrey4,
                                  ),
                                )),
                                child: Row(
                                  children: [
                                    const Icon(Icons.picture_as_pdf),
                                    SizedBox(width: 10 * fem),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(file.name),
                                          Text(formatFileSize(file.size))
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5 * fem),
                                    IconButton(
                                        onPressed: () => _removeFile(file.name),
                                        icon: const Icon(Icons.cancel_rounded))
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                  !uploaded && Get.find<PatientController>().uploading
                      ? Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * fem, vertical: 8 * fem),
                          child: Column(
                            children: [
                              SizedBox(height: 7 * fem),
                              const LinearProgressIndicator(),
                              SizedBox(height: 8 * fem),
                              Row(
                                children: const [Text("Uploading")],
                              )
                            ],
                          ),
                        )
                      : Container(),
                  !uploaded && !Get.find<PatientController>().uploading
                      ? Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * fem, vertical: 5 * fem),
                          child: Button(
                            "Upload ${files.length} files",
                            (BuildContext context) async {
                              String petId =
                                  Get.find<PatientController>().patient!.fmId;
                              String token =
                                  Get.find<AuthController>().token!.accessToken;
                              await Get.find<PatientController>()
                                  .uploadPetDocuments(files, petId, token);
                              Get.find<PatientController>().fetchedPatients =
                                  false;
                              setUploaded(true);
                            },
                            context,
                            backgroundColor: ThemeColors.primaryGreen,
                          ),
                        )
                      : Container(),
                  uploaded
                      ? Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20 * fem, vertical: 8 * fem),
                          child: Column(
                            children: [
                              Container(
                                height: 2 * fem,
                                width: double.infinity,
                                color: ThemeColors.primaryGreen,
                              ),
                              SizedBox(height: 10 * fem),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.check,
                                          color: ThemeColors.primaryGreen),
                                      Text("Complete"),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * fem,
                                        horizontal: 15 * fem),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(5 * fem),
                                      color: ThemeColors.primaryGrey3,
                                    ),
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                        color: ThemeColors.primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          });
  }
}
