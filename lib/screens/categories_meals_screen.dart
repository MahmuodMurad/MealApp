import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';

import 'package:provider/provider.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId='';
 List<Meal> categoryMeal=<Meal>[];

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeals;
    final routeArgument =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryId = routeArgument['id']!;
    categoryMeal = availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     categoryMeal.removeWhere((element) => element.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('categories').toString()),

          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.builder(
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(

            maxCrossAxisExtent: dw<=400?400:500,
            childAspectRatio: isLandScape ?dw/(dw*0.8): dw/(dw*0.75),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: categoryMeal[index].id,
              imageUrl: categoryMeal[index].imageUrl,
              complexity: categoryMeal[index].complexity,
              affordability: categoryMeal[index].affordability,
              duration: categoryMeal[index].duration,
            );
          },
          itemCount: categoryMeal.length,
        ),
      ),
    );
  }
}
