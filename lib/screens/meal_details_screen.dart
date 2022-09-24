import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../date.dart';
import '../models/mails.dart';
import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';

class MealDetailsScreen extends StatelessWidget {
  Widget buildScannedTitle(String text, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 19, 10, 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(ctx).textTheme.bodyText2,
      ),
    );
  }

  Widget buildContaener(
      Widget child, double divesWidth, double divesHight, bool isLandscape) {
    return Container(
      height: isLandscape ? divesHight * 0.5 : divesHight * 0.25,
      width: isLandscape ? (divesWidth * 0.5 - 16) : divesWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  static const routeName = '/maelDitelis_Routs';

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    double divesWidth = MediaQuery.of(context).size.width;
    double divesHight = MediaQuery.of(context).size.height;

    final String maleId = ModalRoute.of(context)!.settings.arguments.toString();
    final Mail selctedMeal =
        DUMMY_MEALS.firstWhere((mael) => mael.id == maleId);
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    ListView listView1 = ListView.builder(
      itemCount: lan.getTexts('ingredients-$maleId').length,
      itemBuilder: (ctx, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            lan.getTexts('ingredients-$maleId')[index],
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
    ListView listView2 = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).colorScheme.secondary,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    lan.isEn ? '${index + 1} -' : '${index + 1} -',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                title: Text(
                  '${lan.getTexts('steps-$maleId')[index]}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                horizontalTitleGap: 5,
                minVerticalPadding: 5,
                style: ListTileStyle.drawer,
                selected: false,
              ),
            ),
          ),
        ],
      ),
      itemCount: lan.getTexts('steps-$maleId').length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${lan.getTexts('meal-$maleId')}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  expandedTitleScale: 1.8,
                  titlePadding: const EdgeInsets.only(bottom: 12),
                  background: Hero(
                    tag: maleId,
                    child: InteractiveViewer(
                      maxScale: 3,
                      child: FadeInImage(
                        image: NetworkImage(
                          selctedMeal.imageUrl,
                        ),
                        placeholder: const AssetImage(
                          'assets/images/forgroundImage.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                if (isLandscape)
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              buildScannedTitle(
                                  '${lan.getTexts('Ingredients')}', context),
                              SizedBox(
                                width: divesWidth / 2.5,
                              ),
                              buildScannedTitle(
                                  '${lan.getTexts('steps')}', context),
                            ],
                          ),
                          Row(
                            children: [
                              buildContaener(listView1, divesWidth, divesHight,
                                  isLandscape),
                              buildContaener(listView2, divesWidth, divesHight,
                                  isLandscape),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                if (!isLandscape)
                  buildScannedTitle('${lan.getTexts('Ingredients')}', context),
                if (!isLandscape)
                  buildContaener(
                      listView1, divesWidth, divesHight, isLandscape),
                if (!isLandscape)
                  buildScannedTitle('${lan.getTexts('steps')}', context),
                if (!isLandscape)
                  buildContaener(
                      listView2, divesWidth, divesHight, isLandscape),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 85, vertical: 0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctn) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Theme.of(ctn).canvasColor,
                              child: SizedBox(
                                height: isLandscape
                                    ? MediaQuery.of(context).size.height / 1.9
                                    : MediaQuery.of(context).size.height / 4,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '${lan.getTexts('delete_wor_msg')}',
                                        textAlign: TextAlign.center,
                                        style:
                                            Theme.of(ctn).textTheme.headline4,
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text('${lan.getTexts('delete_wor_msg2')}',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(ctn)
                                              .textTheme
                                              .headline2),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(ctn).pop(maleId);
                                        },
                                        child: Text(
                                          '${lan.getTexts('delete_confirm')}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).then((value) {
                        Navigator.of(context).pop(value);
                      });
                    },
                    child: Text(
                      lan.getTexts('delete_male'),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(50, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      overlayColor: MaterialStateProperty.all(Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ])),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<MaelProvider>(context, listen: false)
              .toggleFavorite(maleId),
          child: Icon(
            Provider.of<MaelProvider>(context, listen: true).isFavorite(maleId)
                ? Icons.star
                : Icons.star_border,
          ),
        ),
      ),
    );
  }
}
