import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/screens/home_screen.dart';
import 'package:tasky_app_last_thing/screens/welcome_screen.dart';
import 'package:tasky_app_last_thing/services/preference_manager.dart';
import 'package:tasky_app_last_thing/themes/dark_theme.dart';
import 'package:tasky_app_last_thing/themes/light_theme.dart';
import 'package:tasky_app_last_thing/themes/theme_controller.dart';

import 'screens/main_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
ThemeController().init();
  String? username = PreferenceManager().getString("username");
  runApp( MyApp(username:username ,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable:ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? WelcomeScreen():MainScreen(),
        );
      },

    );
  }
}

