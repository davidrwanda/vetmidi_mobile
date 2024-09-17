import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vetmidi/controllers/auth_controller.dart';
import 'package:vetmidi/core/bindings/root_bindings.dart';
import 'package:vetmidi/core/theme/colors_theme.dart';
import 'package:vetmidi/routes/index.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For session management

import 'core/utils/firebase_api.dart';
import 'core/utils/translations.dart';

Future<void> main() async {
  // Error handling widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      color: Colors.red, // Set the background color to red
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(height: 8),
            Text(
              'Something went wrong!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              details.exceptionAsString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  };  
  
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  // Check token status and redirect accordingly
  String initialRoute = await _getInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));
}

// Function to check if the token is still valid
Future<String> _getInitialRoute() async {
  return AppRoutes.login; // Redirect to login if no valid token
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  
  MyApp({super.key, required this.initialRoute});

  final box = GetStorage();

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
        scaffoldBackgroundColor: ThemeColors.primaryBackground,
      ),
      // Use the determined initial route
      initialRoute: initialRoute,
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
