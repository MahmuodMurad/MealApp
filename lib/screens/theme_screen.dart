import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/language_provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/themes';
  final bool fromOnBoarding;

  const ThemeScreen({Key? key, this.fromOnBoarding = false}) : super(key: key);

  Widget buildRadioListTile(
      ThemeMode themeMode, String txt, IconData icon, BuildContext context) {
    return RadioListTile(
      value: themeMode,
      groupValue: Provider.of<ThemeProvider>(context, listen: true).tm,
      onChanged: (newThemeVal) =>
          Provider.of<ThemeProvider>(context, listen: false)
              .themeModeChange(newThemeVal),
      title: Text(txt),
      secondary: Icon(
        icon,
        color: Theme.of(context).splashColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: fromOnBoarding
              ? null
              : AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Text(lan.getTexts('theme_appBar_title').toString()),
                ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.getTexts('theme_screen_title').toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              buildRadioListTile(
                  ThemeMode.system,
                  lan.getTexts('System_default_theme').toString(),
                  Icons.brightness_6_outlined,
                  context),
              buildRadioListTile(ThemeMode.light, lan.getTexts('light_theme').toString(),
                  Icons.sunny, context),
              buildRadioListTile(ThemeMode.dark, lan.getTexts('dark_theme').toString(),
                  Icons.dark_mode, context),
              buildListTile(context, 'Primary'),
              buildListTile(context, 'Secondary'),
              SizedBox(height: fromOnBoarding?80:0,),
            ],
          ),
          drawer:fromOnBoarding?null: const MainDrawer(),
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, txt) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    var primaryColor =
        Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var secondryColor =
        Provider.of<ThemeProvider>(context, listen: true).secondryColor;

    return ListTile(
      title: Text(
        txt == 'Primary' ? lan.getTexts('primary') .toString(): lan.getTexts('accent').toString(),
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: txt == 'Primary' ? primaryColor : secondryColor,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            elevation: 4,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: txt == 'Primary'
                    ? Provider.of<ThemeProvider>(context).primaryColor
                    : Provider.of<ThemeProvider>(context).secondryColor,
                onColorChanged: (newColor) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .onChanged(newColor, txt == 'Primary' ? 1 : 2),
                colorPickerWidth: 300,
                pickerAreaHeightPercent: 0.7,
                displayThumbColor: true,
                enableAlpha: false,
              ),
            ),
          ),
        );
      },
    );
  }
}
