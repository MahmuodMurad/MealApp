import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.teal;
  var secondryColor = Colors.lightBlue;
  var tm = ThemeMode.system;
  String textTheme = 's';

  onChanged(newColor, n) async {
    n == 1
        ? primaryColor = _setMaterialColor(newColor.hashCode)
        : secondryColor = _setMaterialColor(newColor.hashCode);

    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('primaryColor', primaryColor.value);
    sharedPreferences.setInt('secondryColor', secondryColor.value);
  }

  getThemeColor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    primaryColor = _setMaterialColor(sharedPreferences.getInt('primaryColor')??0xFF009688);
    secondryColor = _setMaterialColor(sharedPreferences.getInt('secondryColor')??0xFF03A9F4);
    notifyListeners();
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.system) {
      textTheme = 's';
    } else if (tm == ThemeMode.dark) {
      textTheme = 'd';
    } else if (tm == ThemeMode.light) {
      textTheme = 'l';
    }
  }

  getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString('textTheme') ?? 's';
    if (textTheme == 's') {
      tm = ThemeMode.system;
    } else if (textTheme == 'd') {
      tm = ThemeMode.dark;
    } else if (textTheme == 'l') {
      tm = ThemeMode.light;
    }
    notifyListeners();
  }

  MaterialColor _setMaterialColor(colorVal) {
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: const Color(0xFFE0F2F1),
        100: const Color(0xFFB2DFDB),
        200: const Color(0xFF80CBC4),
        300: const Color(0xFF4DB6AC),
        400: const Color(0xFF26A69A),
        500: Color(colorVal),
        600: const Color(0xFF00897B),
        700: const Color(0xFF00796B),
        800: const Color(0xFF00695C),
        900: const Color(0xFF004D40),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('textTheme', textTheme);
  }
}
