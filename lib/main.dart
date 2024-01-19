import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vetmidi/core/bindings/root_bindings.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/routes/index.dart';

import 'core/utils/firebase_api.dart';
import 'core/utils/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();

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
      locale: Locale(box.read('locale') ?? 'en'),
      translations: Translation(),
      supportedLocales: const [
        Locale('en'),
      ],
    );
  }
}
