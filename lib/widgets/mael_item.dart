import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mails.dart';
import '../provider/language_provider.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    required this.id,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  void _selectMael(ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetailsScreen.routeName, arguments: id)
        .then((value) {
      if (value != null) Navigator.of(ctx).pop(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: SafeArea(
        child: InkWell(
          onTap: () => _selectMael(context),
          child: Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 6,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                          image: NetworkImage(
                            imageUrl,
                          ),
                          placeholder: const AssetImage(
                            'assets/images/forgroundImage.png',
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: lan.isEn ? 8 : 0,
                      right: lan.isEn ? 0 : 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        margin: EdgeInsets.only(
                            left: lan.isEn ? 10 : 35,
                            right: lan.isEn ? 30 : 10),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          lan.getTexts('meal-$id'),
                          textAlign:
                              lan.isEn ? TextAlign.left : TextAlign.right,
                          style: Theme.of(context).textTheme.subtitle1,
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
                          const Icon(
                            Icons.schedule,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '$duration ${lan.getTexts('min')}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.work,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${lan.getTexts('$affordability')}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                          ),
                          Text(
                            '${lan.getTexts(complexity.toString())}',
                            style: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }
}
