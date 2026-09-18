import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager{
  //2.private instance initialized with private constructor
  static final PreferenceManager _instance = PreferenceManager._internal();
  //1. private constructor
 PreferenceManager._internal();
 //3. factory constructor
factory PreferenceManager() {
  return _instance;
}
//4.private instance of shared Preferences
late final SharedPreferences _preferences;
//5.initialize the private instance of shared Preferences with its value
init()async {
  _preferences = await SharedPreferences.getInstance();
}
 String? getString(String key){
  return _preferences.getString(key);
  }
  Future <bool> setString(String key,String value)async{
  return await _preferences.setString(key, value);
  }
  Future <bool> remove(String key)async{
  return await _preferences.remove(key);
  }
  bool? getBool(String key){
  return _preferences.getBool(key);
  }
  Future <bool> setBool(String key,bool value)async{
  return await  _preferences.setBool(key, value);
      }
int? getInt(String key){
  return _preferences.getInt(key);
}
Future<bool>setInt(String key,int value)async{
  return await _preferences.setInt(key, value);
}
double? getDouble(String key){
  return _preferences.getDouble(key);
}
Future<bool>setDouble(String key,double value)async{
  return await _preferences.setDouble(key, value);
  }
  List<String>?getStringList(String key){
  return _preferences.getStringList(key);
  }
  Future<bool>setStringList(String key,List<String> value)async{
  return await _preferences.setStringList(key, value);
  }
clear()async{
  return await _preferences.clear();
}
}