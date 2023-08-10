import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_meals_screen.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final Color color;
  final String imageUrl;

  const CategoryItem(this.id, this.imageUrl, this.color, {Key? key}) : super(key: key);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return SafeArea(
      child: InkWell(
        onTap: () => selectCategory(context),
        splashColor: color,
        borderRadius: BorderRadius.circular(60),
        child: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.loose,
          children: [
            Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain,
              width: 120,
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(60),
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.5),
                      color,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    lan.getTexts('cat-$id').toString(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
            Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.contain,
              width: 120,
              height: 70,
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}
