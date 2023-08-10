import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  final int duration;

  const MealItem({Key? key,
   required this.id,
   required this.imageUrl,
   required this.complexity,
   required this.affordability,
   required this.duration,
  }) : super(key: key);

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
          MealDetailScreen.routeName,
          arguments: id,
        )
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.5),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/images/a2.png'),
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.255,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text(
                          lan.getTexts('meal-$id').toString(),
                        style:
                            const TextStyle(fontSize: 26, color: Colors.white),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          '$duration ${lan.getTexts('min')}',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          lan.getTexts('$complexity').toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          lan.getTexts('$affordability').toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
