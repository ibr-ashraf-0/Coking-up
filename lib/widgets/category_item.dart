import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String imagePath;

  CategoryItem(
    this.id,
    this.imagePath,
  );

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
    }).then((value) {
      print(value);
      if (value != null) {
        Provider.of<MaelProvider>(ctx, listen: false)
            .removeItem(value.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return SafeArea(
      child: InkWell(
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage(
                image:  NetworkImage(
                  imagePath,
                ),
                fadeInDuration: const Duration(seconds: 1),
                placeholder: const AssetImage(
                  'assets/images/forgroundImage.png',
                ),
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Align(
              alignment:
                  lan.isEn ? const Alignment(-0.85, -0.75) : const Alignment(0.85, -0.75),
              child: Container(
                color: Colors.black38,
                child: Text(
                  lan.getTexts('cat-$id'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    inherit: true,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
