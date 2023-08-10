import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_details';

  const MealDetailScreen({Key? key}) : super(key: key);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget buildContainer(Widget child, double height, double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: width,
      height: height,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    List<String> liIngredient =
        lan.getTexts('ingredients-$mealId') as List<String>;
    List<String> liSteps = lan.getTexts('steps-$mealId') as List<String>;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: lan.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('meal-$mealId').toString()),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: mealId,
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/a2.png'),
                    image: NetworkImage(selectedMeal.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isLandScape)
                Row(
                  children: [
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Ingredients').toString()),
                        buildContainer(
                          ListView.builder(
                            itemBuilder: (ctx, index) => Card(
                              color: Theme.of(context).colorScheme.secondary,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Text(
                                  liIngredient[index],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                            itemCount: liIngredient.length,
                          ),
                          isLandScape ? dh * 0.5 : dh * 0.25,
                          isLandScape ? (dw * 0.5 - 20) : dw,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Steps').toString()),
                        buildContainer(
                          ListView.builder(
                            itemBuilder: (ctx, index) => Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: Text('# ${index + 1}'),
                                  ),
                                  title: Text(liSteps[index]),
                                ),
                                const Divider(
                                  color: Colors.white10,
                                )
                              ],
                            ),
                            itemCount: liSteps.length,
                          ),
                          isLandScape ? dh * 0.5 : dh * 0.25,
                          isLandScape ? (dw * 0.5 - 20) : dw,
                        ),
                      ],
                    ),
                  ],
                ),
              if (!isLandScape)
                const SizedBox(
                  height: 8,
                ),
              if (!isLandScape)
                buildSectionTitle(context, lan.getTexts('Ingredients').toString()),
              if (!isLandScape)
                const SizedBox(
                  height: 8,
                ),
              if (!isLandScape)
                buildContainer(
                  ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          liIngredient[index],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    itemCount: liIngredient.length,
                  ),
                  isLandScape ? dh * 0.5 : dh * 0.25,
                  isLandScape ? (dw * 0.5 - 20) : dw,
                ),
              if (!isLandScape)
                const SizedBox(
                  height: 8,
                ),
              if (!isLandScape) buildSectionTitle(context, lan.getTexts('Steps').toString()),
              if (!isLandScape)
                const SizedBox(
                  height: 8,
                ),
              if (!isLandScape)
                buildContainer(
                  ListView.builder(
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${index + 1}'),
                          ),
                          title: Text(liSteps[index]),
                        ),
                        const Divider(
                          color: Colors.white10,
                        )
                      ],
                    ),
                    itemCount: liSteps.length,
                  ),
                  isLandScape ? dh * 0.5 : dh * 0.25,
                  isLandScape ? (dw * 0.5 - 20) : dw,
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
          child: Icon(Provider.of<MealProvider>(context, listen: true)
                  .isMealFavorite(mealId)
              ? Icons.favorite
              : Icons.favorite_border),
        ),
      ),
    );
  }
}
