import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  late SharedPreferences storage;

  // Dark theme setting
  final ThemeData darkTheme = ThemeData(
    cardColor:Colors.white ,
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    backgroundColor: const Color(0xFF212121),
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      surface: Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.black12,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white54),
    ),
  );


  // Light theme settings
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFFE5E5E5),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.white54,
    textTheme: TextTheme(
      bodySmall:TextStyle(color: Colors.black) ,
      bodyMedium:TextStyle(color: Colors.black) ,
      bodyLarge:  TextStyle(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Color(0xff8e3200)),
      hintStyle: TextStyle(color: Colors.black54),
    ),
  );

  // Dark mode toggle action
  //now  we want to save the last change theme
  // Dark mode toggle action
  void changeTheme() {
    _isDark = !_isDark;
    //save the value to se
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  void init() async{
   storage=await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark")??false;
    notifyListeners();
  }
}
