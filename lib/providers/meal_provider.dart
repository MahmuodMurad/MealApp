import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> prefsMealId = [];

  List<Category> availableCategory = [];

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((element) {
      if (filters['gluten']! && !element.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !element.isLactoseFree) {
        return false;
      }
      if (filters['vegetarian']! && !element.isVegetarian) {
        return false;
      }
      if (filters['vegan']! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();


    List<Category> ac = [];
    for (var meal in availableMeals) {
      for (var catId in meal.categories) {
        for (var cat in DUMMY_CATEGORIES) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) {
              ac.add(cat);
            }
          }
        }
      }
    }
    availableCategory = ac;

    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('gluten', filters['gluten']!);
    sharedPreferences.setBool('lactose', filters['lactose']!);
    sharedPreferences.setBool('vegetarian', filters['vegetarian']!);
    sharedPreferences.setBool('vegan', filters['vegan']!);
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    filters['gluten'] = sharedPreferences.getBool('gluten') ?? false;
    filters['lactose'] = sharedPreferences.getBool('lactose') ?? false;
    filters['vegetarian'] = sharedPreferences.getBool('vegetarian') ?? false;
    filters['vegan'] = sharedPreferences.getBool('vegan') ?? false;

    prefsMealId = sharedPreferences.getStringList('prefsMealId') ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
          favoriteMeals.indexWhere((element) => element.id == mealId);

      if (existingIndex < 0) {
        favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    }

    List<Meal> fm = [];
    for (var favMeals in favoriteMeals) {
      for (var avMeals in availableMeals) {
        if (favMeals.id == avMeals.id) {
          fm.add(favMeals);
        }
      }
    }

    favoriteMeals = fm;

    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final existingIndex =
        favoriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals
          .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    sharedPreferences.setStringList('prefsMealId', prefsMealId);
  }

  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((element) => element.id == mealId);
  }
}
