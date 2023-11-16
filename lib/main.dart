import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:vetmidi/core/bindings/root_bindings.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/routes/index.dart';

import 'core/utils/translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: ThemeColors.primaryBackground,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      initialBinding: RootBinding(),
      locale: const Locale('en'),
      translations: Translation(),
      supportedLocales: const [
        Locale('en'),
      ],
    );
  }
}
