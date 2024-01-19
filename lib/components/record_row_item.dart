import 'package:flutter/material.dart';
import 'package:vetmidi/models/medical_record.dart';

import '../core/utils/app_constants.dart';

class RecordRowItem extends StatefulWidget {
  const RecordRowItem({
    Key? key,
    required this.record,
  }) : super(key: key);

  final MedicalRecord record;

  @override
  State<RecordRowItem> createState() => _RecordRowItemState();
}

class _RecordRowItemState extends State<RecordRowItem> {
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
      height: 70 * fem,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10 * fem),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: [
          SizedBox(
            width: 90 * fem,
            child: Center(
              child: Text(widget.record.medical_record_title.isEmpty
                  ? "N/A"
                  : widget.record.medical_record_title),
            ),
          ),
          SizedBox(
            width: 110 * fem,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 15 * fem, vertical: 5 * fem),
                decoration: BoxDecoration(
                  color: Color(0xffFBE0F2),
                  borderRadius: BorderRadius.circular(3 * fem),
                ),
                child: Text(
                  widget.record.med_type,
                  style: TextStyle(
                    color: Color(0xffe965be),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
              width: 100 * fem,
              child: Center(child: Text(widget.record.pet_name))),
          SizedBox(
              width: 100 * fem,
              child: Center(child: Text(widget.record.exam_date))),
          SizedBox(
            width: 40,
            child: Center(
              child: Icon(
                Icons.remove_red_eye_outlined,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Center(
              child: Icon(
                Icons.file_download_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
