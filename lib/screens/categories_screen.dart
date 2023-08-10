import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(

        body: GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.05,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: Provider.of<MealProvider>(context).availableCategory
              .map(
                (categoryData) => CategoryItem(
                    categoryData.id,
                    categoryData.imageUrl,
                    categoryData.color),
              )
              .toList(),
        ),
      ),
    );
  }
}
