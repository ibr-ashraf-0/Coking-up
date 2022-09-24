
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mails.dart';
import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../widgets/mael_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/CategoryMealsScreen';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Mail> displayMeals;
  var idArg;

  @override
  void didChangeDependencies() {
    final List<Mail> _availableMael = Provider.of<MaelProvider>(context,listen: true).availableMael;
    final argumentCategory =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
     idArg = argumentCategory['id'];
    displayMeals = _availableMael.where((mael) {
      return mael.categories.contains(idArg);
    }).toList();

    super.didChangeDependencies();
  }

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    double divesWidth=MediaQuery.of(context).size.width;
    double divesHight=MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            lan.getTexts('cat-$idArg'),
          ),
        ),
        body: SafeArea(
          child: GridView.builder(
              itemCount: displayMeals.length,
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: displayMeals[index].id,
                  imageUrl: displayMeals[index].imageUrl,
                  duration: displayMeals[index].duration,
                  affordability: displayMeals[index].affordability,
                  complexity: displayMeals[index].complexity,
                );
              },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: isLandscape ?divesWidth /2 : divesWidth / 1.0,
              childAspectRatio: isLandscape ? divesWidth/(divesWidth* 0.7) : divesHight/(divesHight*0.75),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
              ),
        ),
      ),
    );
  }
}
