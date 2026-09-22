
import 'package:flutter/material.dart';
import 'package:tasky_app_last_thing/core/constance/storage_key.dart';
import 'package:tasky_app_last_thing/core/services/preference_manager.dart';

class ThemeController{
  static final ValueNotifier<ThemeMode> themeNotifier=ValueNotifier(ThemeMode.dark);
 init(){
   bool result = PreferenceManager().getBool(StorageKey.theme)??true;
  themeNotifier.value = result == true ? ThemeMode.dark : ThemeMode.light;
 }

 static toggleTheme()async{
   if(themeNotifier.value == ThemeMode.dark){
     themeNotifier.value=ThemeMode.light;
    await PreferenceManager().setBool(StorageKey.theme, false);
   }else{
     themeNotifier.value=ThemeMode.dark;
     await PreferenceManager().setBool(StorageKey.theme, true);

   }

 }
}