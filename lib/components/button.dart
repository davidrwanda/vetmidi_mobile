import 'package:flutter/material.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';

import '../core/utils/app_constants.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final BuildContext context;
  final Function onPressed;
  final bool loading, customColor, hasIcon, hasBorder;
  final IconData icon;
  final Color color, backgroundColor;
  final double marginTop, width, height, radius, fontSize;
  final FontWeight weight;

  // ignore: use_key_in_widget_constructors
  const Button(
    this.buttonText,
    this.onPressed,
    this.context, {
    this.color = Colors.white,
    this.backgroundColor = Colors.blue,
    this.marginTop = 0,
    this.loading = false,
    this.customColor = false,
    this.hasIcon = false,
    this.hasBorder = false,
    this.icon = Icons.search,
    this.height = 40,
    this.width = double.infinity,
    this.fontSize = 17,
    this.weight = FontWeight.w700,
    this.radius = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: hasBorder ? ThemeColors.secondaryColor : Colors.transparent,
          )
          // ignore: prefer_const_constructors
          ),
      child: ElevatedButton(
        onPressed: () async {
          await onPressed(context);
        },
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(Size(width, height * fem)),
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
          elevation: WidgetStateProperty.all<double>(0),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        child: !loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasIcon ? Icon(icon) : const Text(""),
                  hasIcon ? const SizedBox(width: 5) : const SizedBox(width: 1),
                  Text(
                    buttonText,
                    style: TextStyle(color: color, fontSize: fontSize * ffem),
                  ),
                ],
              )
            : SizedBox(
                height: 30 * fem,
                width: 30 * fem,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white54,
                ),
              ),
      ),
    );
  }
}
