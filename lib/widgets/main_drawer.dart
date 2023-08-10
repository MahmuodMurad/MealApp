import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../screens/filters_screen.dart';
import '../screens/tabs_screen.dart';
import '../screens/theme_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, Color textColor,
      Color iconColor, Function() tabHandle) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
          fontFamily: 'RobotoCondensed',
        ),
      ),
      onTap: tabHandle,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Drawer(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        child: Column(
          children: [
            const Image(
              image: NetworkImage(
                  'https://t4.ftcdn.net/jpg/03/10/58/11/360_F_310581123_Fzo4MSicY8U2y6teZXLt3cMwcwuijxpp.jpg'),
              fit: BoxFit.fill,
              width: double.infinity,
              height: 200,
            ),
            Container(
              height: 120,
              width: double.infinity,
              alignment: lan.isEn?Alignment.centerLeft:Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              color: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              child: Text(
                lan.getTexts('drawer_name').toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            buildListTile(
               lan.getTexts('drawer_item1').toString(),
                Icons.restaurant_sharp,
                Theme
                    .of(context)
                    .primaryColor,
                Theme
                    .of(context)
                    .primaryColorLight, () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            }),
            const SizedBox(
              height: 30,
            ),
            buildListTile(
                lan.getTexts('drawer_item2').toString(),
                Icons.filter_list_alt,
                Theme
                    .of(context)
                    .primaryColor,
                Theme
                    .of(context)
                    .primaryColorLight, () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            }),
            const SizedBox(
              height: 30,
            ),
            buildListTile(
                lan.getTexts('drawer_item3').toString(),
                Icons.color_lens,
                Theme
                    .of(context)
                    .primaryColor,
                Theme
                    .of(context)
                    .primaryColorLight, () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
            }),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20, right: 22),
              child: Text(
                lan.getTexts('drawer_switch_title').toString(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: (lan.isEn ? 0 : 20),
                left: (lan.isEn ? 20 : 0),
                bottom: 20,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lan.getTexts('drawer_switch_item2').toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),
                  Switch(
                    value:
                    Provider
                        .of<LanguageProvider>(context, listen: true)
                        .isEn,
                    onChanged: (newVal) {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLan(newVal);
                      Navigator.of(context).pop();
                    },
                    inactiveTrackColor:  Provider.of<ThemeProvider>(context, listen: true).tm ==
                        ThemeMode.light
                        ? null
                        : Colors.black,
                  ),
                  Text(
                    lan.getTexts('drawer_switch_item1').toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6,
                  ),

                ],
              ),
            ),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
