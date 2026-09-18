import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';
import 'package:tasky_app_last_thing/core/themes/theme_controller.dart';
import 'package:tasky_app_last_thing/features/home/home_screen.dart';
import 'package:tasky_app_last_thing/features/welcome/welcome_screen.dart';

import 'core/themes/dark_theme.dart';
import 'core/themes/light_theme.dart';
import 'features/navigation/main_screen.dart';


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

