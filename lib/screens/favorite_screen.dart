import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw =MediaQuery.of(context).size.width;
    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    if (favoriteMeals.isEmpty) {
      return  Directionality(
        textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
        child: Center(
          child: Text(lan.getTexts('favorites_text').toString()),
        ),
      );
    } else {
      return Directionality(
        textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
        child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: dw<=400?400:500,
            childAspectRatio: isLandScape ?dw/(dw*0.8): dw/(dw*0.75),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (ctx, index) {
            return MealItem(
              id: favoriteMeals[index].id,
              imageUrl: favoriteMeals[index].imageUrl,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              duration: favoriteMeals[index].duration,
            );
          },
          itemCount: favoriteMeals.length,
        ),
      );
    }
  }
}
