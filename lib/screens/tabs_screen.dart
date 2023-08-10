import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const routeName='tabs_screen';

  const TabsScreen({Key? key}) : super(key: key);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages=[];

  @override
  void initState() {
    Provider.of<MealProvider>(context, listen: false).getData();
    Provider.of<ThemeProvider>(context, listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context, listen: false).getThemeColor();
    Provider.of<LanguageProvider>(context, listen: false).getLan() ;
    // var lan = Provider.of<LanguageProvider>(context, listen: true);
    

    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    _pages = [
      {'page': const CategoriesScreen(),'title':lan.getTexts('categories'), },
      {'page': const FavoritesScreen(),'title':lan.getTexts('your_favorites'), },
    ];
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text( _pages[_selectedPageIndex]['title'].toString()),
        ),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme:
              IconThemeData(color: Theme.of(context).splashColor),
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).splashColor,
          currentIndex: _selectedPageIndex,
          items:  [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: lan.getTexts('categories').toString(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_sharp),
              label: lan.getTexts('your_favorites').toString(),
            ),
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
