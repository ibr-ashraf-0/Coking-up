


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvidr extends ChangeNotifier{
  var canvasColor = const Color.fromRGBO(206, 147, 216, 1);
  var primeryColor = Colors.purple;
  var themeMood = ThemeMode.system;
  String themeText = 'system';

  onChange (color , n) async {
    n == 1
        ? primeryColor = _toMaterialColor(color.hashCode)
        : canvasColor = _toMaterialColor(color.hashCode);
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('primeryColor', primeryColor.value);
    pref.setInt('canvasColor', canvasColor.value);
  }
  void getColorsFromSharedPref()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    primeryColor =_toMaterialColor(pref.getInt('primeryColor')??0xFF9C27B0);
    canvasColor = _toMaterialColor(pref.getInt('canvasColor')??0xFFCE93D8);
    notifyListeners();
  }

  MaterialColor _toMaterialColor (int colorVal){
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: const Color(0xFFF3E5F5),
        100: const Color(0xFFE1BEE7),
        200: const Color(0xFFCE93D8),
        300: const Color(0xFFBA68C8),
        400: const Color(0xFFAB47BC),
        500: Color(colorVal),
        600: const Color(0xFF8E24AA),
        700: const Color(0xFF7B1FA2),
        800: const Color(0xFF6A1B9A),
        900: const Color(0xFF4A148C),
      },
    );
  }


  void themeModeChange(newThemeMode) async {
    themeMood = newThemeMode;
    _getThemeModeText(themeMood);
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('themeMode', themeText);
  }

  void _getThemeModeText(ThemeMode tm){
    if(tm == ThemeMode.light){
      themeText = 'light';
    }else if(tm == ThemeMode.dark){
      themeText = 'dark';
    }else if(tm == ThemeMode.system){
      themeText = 'system';
    }
  }

  void getThemeFromSharedPref()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   themeText = pref.getString('themeMode')??'system';
    if( themeText == 'light'){
      themeMood = ThemeMode.light;
    }else if( themeText == 'dark'){
      themeMood = ThemeMode.dark;
    }else if(themeText == 'system'){
      themeMood = ThemeMode.system;
    }
    notifyListeners();
  }
}