

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/mails.dart';
import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../widgets/mael_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Mail> favouriteMeals =
        Provider.of<MaelProvider>(context, listen: true).favouriteMael;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double divesWidth = MediaQuery.of(context).size.width;
    double divesHight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);

    if (favouriteMeals.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(lan.getTexts('favorites_appBar_title')),
        ),
        body: Center(
          child: Text(
            '${lan.getTexts('favorites_text')}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              pinned: false,
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(lan.getTexts('favorites_appBar_title')),
              ),
              elevation: 5,
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: isLandscape
                      ? favouriteMeals.length * 170
                      : favouriteMeals.length * 320,
                  child: GridView.builder(
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouriteMeals.length,
                    itemBuilder: (ctx, index) {
                      return MealItem(
                        id: favouriteMeals[index].id,
                        imageUrl: favouriteMeals[index].imageUrl,
                        duration: favouriteMeals[index].duration,
                        affordability: favouriteMeals[index].affordability,
                        complexity: favouriteMeals[index].complexity,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          isLandscape ? divesWidth / 2 : divesWidth / 1.0,
                      childAspectRatio: isLandscape
                          ? divesWidth / (divesWidth * 0.7)
                          : divesHight / (divesHight * 0.75),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 0,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      );
    }
  }
}
