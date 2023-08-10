import 'package:flutter/material.dart';
import 'package:meal_app/providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';
  final bool fromOnBoarding;

  const FiltersScreen({Key? key, this.fromOnBoarding = false}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  initState() {
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      value: currentValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    return SafeArea(
      child: Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: widget.fromOnBoarding
              ? null
              : AppBar(
                  title: Text(lan.getTexts('filters_appBar_title').toString()),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  lan.getTexts('filters_screen_title').toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildSwitchListTile(
                      lan.getTexts('Gluten-free').toString(),
                      lan.getTexts('Gluten-free-sub').toString(),
                      currentFilters['gluten']!,
                      (newValue) {
                        setState(() {
                          currentFilters['gluten'] = newValue;
                        });
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilters();
                      },
                    ),
                    buildSwitchListTile(
                      lan.getTexts('Lactose-free').toString(),
                      lan.getTexts('Lactose-free_sub').toString(),
                      currentFilters['lactose']!,
                      (newValue) {
                        setState(() {
                          currentFilters['lactose'] = newValue;
                        });
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilters();
                      },
                    ),
                    buildSwitchListTile(
                      lan.getTexts('Vegetarian').toString(),
                      lan.getTexts('Vegetarian-sub').toString(),
                      currentFilters['vegetarian']!,
                      (newValue) {
                        setState(() {
                          currentFilters['vegetarian'] = newValue;
                        });
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilters();
                      },
                    ),
                    buildSwitchListTile(
                      lan.getTexts('Vegan').toString(),
                      lan.getTexts('Vegan-sub').toString(),
                      currentFilters['vegan']!,
                      (newValue) {
                        setState(() {
                          currentFilters['vegan'] = newValue;
                        });
                        Provider.of<MealProvider>(context, listen: false)
                            .setFilters();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: widget.fromOnBoarding ? null : MainDrawer(),
        ),
      ),
    );
  }
}
