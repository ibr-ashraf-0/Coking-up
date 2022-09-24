import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/mainDrawer.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double divesWidth = MediaQuery.of(context).size.width;
    double divesHight = MediaQuery.of(context).size.height;
    var lan = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          return Future.delayed(const Duration(seconds: 2),() {
            setState((){
            print('refresh');
          });
          },);
        },
        child: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          height: divesHight + 100,
          child: Directionality(
            textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
            child: CustomScrollView(
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
                      child: Text(lan.getTexts('category_appBar_title'))),
                  elevation: 5,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: isLandscape
                            ? Provider.of<MaelProvider>(context)
                                    .availableCategory
                                    .length *
                                115
                            : divesHight + 150,
                        child: GridView(
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          children: Provider.of<MaelProvider>(context)
                              .availableCategory
                              .map((catDate) {
                            return CategoryItem(
                              catDate.id,
                              catDate.imagePath,
                            );
                          }).toList(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                isLandscape ? 400 : divesWidth / 1.5,
                            childAspectRatio: isLandscape
                                ? divesWidth / (divesWidth * 0.51)
                                : divesHight / (divesHight * 1.22),
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
