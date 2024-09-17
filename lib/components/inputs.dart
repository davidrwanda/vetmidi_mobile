import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

import '../core/theme/colors_theme.dart';
import '../core/utils/app_constants.dart';
import 'package:flutter/services.dart';  // Add this import

class InputText extends StatelessWidget {
  final String hintText, icon, errorText, label;
  final Color backgroundColor;
  final double marginTop, width, height, fontSize;
  final bool showBorder, showIcon, valid, required, changed;
  final bool numberKeyboard, isPassword, readOnly;
  final TextEditingController txtController;
  final Function? setValid, setChanged;

  // ignore: use_key_in_widget_constructors
  const InputText(
    this.hintText,
    this.txtController, {
    this.numberKeyboard = false,
    this.label = "",
    this.isPassword = false,
    this.valid = true,
    this.changed = false,
    this.required = false,
    this.readOnly = false,
    this.errorText = 'This field can\'t be empty',
    this.icon = 'auth_user.svg',
    this.marginTop = 5,
    this.fontSize = 14,
    this.backgroundColor = Colors.white,
    this.showBorder = false,
    this.showIcon = true,
    this.height = 45,
    this.width = double.infinity,
    this.setValid,
    this.setChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            required
                ? const Text("*", style: TextStyle(color: Colors.red))
                : Container(),
            required ? SizedBox(width: 10 * fem) : Container(),
            label.isNotEmpty ? Text(label) : Container(),
          ],
        ),
        Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(top: marginTop),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5 * fem),
            color: backgroundColor,
            border: Border.all(
                color: valid ? ThemeColors.primaryGrey4 : Colors.red),
          ),
          child: TextField(
                obscureText: isPassword,
                readOnly: readOnly,
                style: TextStyle(
                    color: ThemeColors.textColor, fontSize: fontSize * ffem),
                keyboardType: numberKeyboard ? TextInputType.number : TextInputType.text,
                  inputFormatters: numberKeyboard ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))]
                    : [],
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: ThemeColors.textColor, fontSize: fontSize * ffem),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(10.0),
                ),
                onChanged: (value) {
                  if (setValid != null && required && value.isEmpty) {
                    setValid!(false);
                  }
                  if (setValid != null && !valid && required && value.isNotEmpty) {
                    setValid!(true);
                  }
                  if (setChanged != null && !changed) {
                    setChanged!();
                  }
                },
                controller: txtController,
              ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.only(left: 5),
          margin: valid
              ? EdgeInsets.only(bottom: 0 * fem)
              : EdgeInsets.only(bottom: 10 * fem),
          width: double.infinity,
          child: Text(
            !valid ? errorText : "",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}

Widget textInput({
  required String hintText,
  required TextEditingController controller,
  required double fontSize,
  double height = 50,
  bool numerical = false,
  bool enabled = false,
  bool valid = true,
}) {
  return Container(
    height: height * fem,
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: valid ? Colors.black54 : Colors.red),
    ),
    child: TextField(
      style: TextStyle(fontSize: fontSize),
      textAlignVertical: TextAlignVertical.center,
      keyboardType: numerical ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        enabled: enabled,
        hintStyle: TextStyle(fontSize: fontSize),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(10.0),
      ),
      controller: controller,
    ),
  );
}
Widget numberInput({
  required String hintText,
  required TextEditingController controller,
  required double fontSize,
  double height = 50,
  bool enabled = false,
  bool valid = true,
}) {
  return Container(
    height: height * fem,
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: valid ? Colors.black54 : Colors.red),
    ),
    child: TextField(
      style: TextStyle(fontSize: fontSize),
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.numberWithOptions(decimal: true),  // Allow numbers with decimal
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),  // Allow numbers and optional decimals
      ],
      decoration: InputDecoration(
        hintText: hintText,
        enabled: enabled,
        hintStyle: TextStyle(fontSize: fontSize),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(10.0),
      ),
      controller: controller,
    ),
  );
}

Widget searchInput(
    {required Function onChanged,
    required Function clearSearch,
    required TextEditingController controller,
    required double fontSize,
    double height = 40.0,
    bool numerical = false,
    bool enabled = true,
    bool valid = true,
    String hintText = "Search"}) {
  return Container(
    height: height,
    width: double.infinity,
    padding: const EdgeInsets.only(bottom: 4, left: 10, right: 10),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        // border: Border.all(color: valid ? Colors.black54 : Colors.red),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // The offset of the shadow
          ),
        ]),
    child: TextField(
      style: TextStyle(fontSize: fontSize),
      textAlignVertical: TextAlignVertical.center,
      keyboardType: numerical ? TextInputType.number : TextInputType.text,
      onChanged: ((value) {
        onChanged(value);
      }),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              controller.text = "";
              clearSearch();
            }
          },
          icon: controller.text.isEmpty
              ? const Icon(Icons.search)
              : const Icon(Icons.close),
        ),
        hintText: hintText,
        enabled: enabled,
        hintStyle: TextStyle(fontSize: fontSize),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(10.0),
      ),
      controller: controller,
    ),
  );
}

Widget select(String label, String? value, List<String> items,
    Function valueChangedHandler,
    {bool valid = true,
    String errorText = "",
    bool required = false,
    bool readOnly = false,
    double height = 45,
    double width = double.infinity}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          required
              ? const Text("*", style: TextStyle(color: Colors.red))
              : Container(),
          required ? SizedBox(width: 10 * fem) : Container(),
          label.isNotEmpty ? Text(label) : Container(),
        ],
      ),
      Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(top: 5 * fem),
        decoration: BoxDecoration(
          border: valid
              ? Border.all(color: ThemeColors.primaryGrey4)
              : Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: value ?? "no_value",
              icon: const Icon(Icons.arrow_drop_down_sharp,
                  color: ThemeColors.textColor),
              elevation: 3,
              dropdownColor: Colors.white,
              style: const TextStyle(color: ThemeColors.textColor),
              underline: null,
              hint: const Text("Select an option"),
              onChanged: readOnly
                  ? null
                  : (String? newValue) {
                      if (newValue != "no_value") {
                        valueChangedHandler(newValue);
                      }
                    },
              items: [
                DropdownMenuItem<String>(
                  value: "no_value",
                  child: Text(
                    "page.petData.select".tr,
                    style: const TextStyle(color: ThemeColors.textColor),
                  ),
                ),
                ...items.map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value!.tr,
                      style: const TextStyle(color: ThemeColors.textColor),
                    ),
                  );
                }).toList(),
              ]),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 5),
        margin: valid
            ? EdgeInsets.only(bottom: 0 * fem)
            : EdgeInsets.only(bottom: 10 * fem),
        width: double.infinity,
        child: Text(
          !valid ? errorText : "",
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      )
    ],
  );
}

Widget selectInput(
    String? value, List<String> items, Function valueChangedHandler,
    {bool valid = true,
    String errorText = "",
    double width = double.infinity}) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      border: valid
          ? Border.all(color: ThemeColors.primaryGrey4)
          : Border.all(color: Colors.red),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down_sharp,
            color: ThemeColors.textColor),
        elevation: 0,
        dropdownColor: Colors.white,
        // style: const TextStyle(color: ThemeColors.textColor),
        style: const TextStyle(color: ThemeColors.textColor),
        underline: null,
        hint: const Text("Select an option"),
        onChanged: (String? newValue) {
          valueChangedHandler(newValue);
        },
        items: items.map<DropdownMenuItem<String>>((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value!,
              style: const TextStyle(color: ThemeColors.textColor),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

Column datePicker(
    {required String label,
    required String value,
    required BuildContext context,
    required Function onChange,
    bool valid = true,
    bool readOnly = false,
    bool required = false,
    String errorText = ""}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          required
              ? const Text("*", style: TextStyle(color: Colors.red))
              : Container(),
          required ? SizedBox(width: 10 * fem) : Container(),
          label.isNotEmpty ? Text(label) : Container(),
        ],
      ),
      SizedBox(height: 10 * fem),
      GestureDetector(
        onTap: () async {
          if (!readOnly) {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              locale: Locale('fr')
            );

            if (picked != null) {
              DateFormat formatter = DateFormat('MM/dd/yyyy');
              onChange(formatter.format(picked));
            }
          }
        },
        child: Container(
          width: double.infinity,
          height: 45 * fem,
          padding: EdgeInsets.symmetric(horizontal: 10 * fem),
          decoration: BoxDecoration(
            border: Border.all(
                color: valid ? ThemeColors.primaryGrey4 : Colors.red),
            borderRadius: BorderRadius.circular(5 * fem),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value.isNotEmpty ? value : "mm/dd/yyyy"),
              readOnly
                  ? Container()
                  : Icon(Icons.calendar_today, size: 16 * ffem),
            ],
          ),
        ),
      ),
      const SizedBox(height: 4),
      Container(
        padding: const EdgeInsets.only(left: 5),
        margin: valid
            ? EdgeInsets.only(bottom: 0 * fem)
            : EdgeInsets.only(bottom: 10 * fem),
        width: double.infinity,
        child: Text(
          !valid ? errorText : "",
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      )
    ],
  );
}
