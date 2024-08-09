import 'package:flutter/material.dart';

import '../../core/theme/colors_theme.dart';
import '../../core/utils/app_constants.dart';

class SelectType extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final Function onChange;

  const SelectType(
      {super.key,
      required this.tabs,
      required this.selectedIndex,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15 * fem, 20 * fem, 15 * fem),
      child: Row(
        children: [
          ...tabs
              .asMap()
              .entries
              .map((entry) => GestureDetector(
                    onTap: () => onChange(entry.key),
                    child: Container(
                      margin: EdgeInsets.only(right: 20 * fem),
                      padding: EdgeInsets.only(bottom: 10 * fem),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: entry.key == selectedIndex
                                ? ThemeColors.secondaryColor
                                : Colors.transparent,
                            width: 2.0 * fem,
                          ),
                        ),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontWeight: entry.key == selectedIndex
                              ? FontWeight.w800
                              : FontWeight.w300,
                        ),
                      ),
                    ),
                  ))
              .toList()
        ],
      ),
    );
  }
}
