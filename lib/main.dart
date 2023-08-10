import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';

import 'package:meal_app/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/categories_meals_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  Widget homeScreen=sharedPreferences.getBool('watched')??false?const TabsScreen():const OnBoardingScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(
          create: (context) => MealProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: MyApp(homeScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget homeScreen;
   const MyApp(this.homeScreen, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var primaryColor =Provider.of<ThemeProvider>(context,listen: true).primaryColor;
    var secondryColor =Provider.of<ThemeProvider>(context,listen: true).secondryColor;
    var tm =Provider.of<ThemeProvider>(context,listen: true).tm;
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      themeMode: tm,
      darkTheme: ThemeData(
        unselectedWidgetColor: Colors.white70,
        primaryColor: primaryColor,
        primaryColorDark: Colors.grey[200],
        primaryColorLight: Colors.grey[400],
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(secondary: secondryColor),
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: const Color(0xff17191D),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xff17191D),
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        splashColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Colors.black,
              ),
              bodyText2: const TextStyle(
                color: Colors.white70,
              ),
              headline6: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: Colors.grey[500],
        primaryColorLight: Colors.grey[200],
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(secondary: secondryColor),
        primarySwatch: primaryColor,
        scaffoldBackgroundColor: Colors.white70,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white70,
            statusBarIconBrightness: Brightness.dark,
          ),

          elevation: 0.0,
          iconTheme: (IconThemeData(color: Colors.black)),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        splashColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Colors.white70,
              ),
              bodyText2: const TextStyle(
                color: Colors.black,
              ),
              headline6: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => homeScreen,
        TabsScreen.routeName: (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (context) => const MealDetailScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen(),
        ThemeScreen.routeName: (context) => const ThemeScreen(),
      },
    );
  }
}
