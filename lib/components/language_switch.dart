import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/app_constants.dart';
import '../core/utils/translations.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30 * fem,
        width: 80 * fem,
        child: Row(
          children: [
            Image.asset(Translation.languages
                .firstWhere(
                    (element) => element.code == Get.locale?.languageCode)
                .flag),
            SizedBox(width: 8 * fem),
            SizedBox(
              width: 45 * fem,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    value: Translation.languages
                        .firstWhere((element) =>
                            element.code == Get.locale?.languageCode)
                        .code,
                    isExpanded: true,
                    selectedItemBuilder: (context) => Translation.languages
                        .map(
                          (e) => Container(
                              margin: EdgeInsets.only(top: 5 * fem),
                              child: Text(e.displayName)),
                        )
                        .toList(),
                    items: Translation.languages
                        .map(
                          (language) => DropdownMenuItem(
                            value: language.code,
                            child: Text(language.displayName),
                          ),
                        )
                        .toList(),
                    onChanged: (String? code) {
                      if (code != null) {
                        Get.updateLocale(Locale(code));
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
