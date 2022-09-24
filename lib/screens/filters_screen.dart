

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../widgets/mainDrawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/FiltersScreen';
  bool fromBoarding;

  FiltersScreen({this.fromBoarding = false});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildSwitch(
      String title, String subTitle, bool currentValue, var upDateValue) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      activeColor: Theme.of(context).primaryColor,
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      value: currentValue,
      onChanged: upDateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    final Map<String, bool> currentFilters =
        Provider.of<MaelProvider>(context, listen: true).filters;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 85,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              pinned: false,
              centerTitle: true,
              backgroundColor: widget.fromBoarding ? Theme.of(context).canvasColor:Theme.of(context).primaryColor,
              title: widget.fromBoarding ? null:Padding(padding: const EdgeInsets.only(top: 15),child: Text('${lan.getTexts('filters_appBar_title')}')),
              elevation: widget.fromBoarding? 0.0: 5,

            ),
            SliverList(delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '${lan.getTexts('filters_screen_title')}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                        buildSwitch(
                            '${lan.getTexts('Gluten-free')}',
                            '${lan.getTexts('Gluten-free-sub')}',
                            currentFilters['gluten']!, (newValue) {
                          setState(() {
                            currentFilters['gluten'] = newValue;
                          });
                          Provider.of<MaelProvider>(context, listen: false)
                              .setFiltters();
                        }),
                        buildSwitch(
                          '${lan.getTexts('Lactose-free')}',
                          '${lan.getTexts('Lactose-free-sub')}',
                          currentFilters['Lactose']!,
                              (newValue) {
                            setState(() {
                              currentFilters['Lactose'] = newValue;
                            });
                            Provider.of<MaelProvider>(context, listen: false)
                                .setFiltters();
                          },
                        ),
                        buildSwitch(
                          '${lan.getTexts('Vegetarian-free')}',
                          '${lan.getTexts('Vegetarian-free-sub')}',
                          currentFilters['Vegetarian']!,
                              (newValue) {
                            setState(() {
                              currentFilters['Vegetarian'] = newValue;
                            });
                            Provider.of<MaelProvider>(context, listen: false)
                                .setFiltters();
                          },
                        ),
                        buildSwitch(
                          '${lan.getTexts('Vegan-free')}',
                          '${lan.getTexts('Vegan-free-sub')}',
                          currentFilters['Vegan']!,
                              (newValue) {
                            setState(() {
                              currentFilters['Vegan'] = newValue;
                            });
                            Provider.of<MaelProvider>(context, listen: false)
                                .setFiltters();
                          },
                        ),
                        if (!widget.fromBoarding)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(25)),
                            margin:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<MaelProvider>(context, listen: false)
                                    .setFiltters();
                              },
                              child: Text(
                                '${lan.getTexts('save_filters')}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                                overlayColor:
                                MaterialStateProperty.all(Colors.white30),
                                padding: MaterialStateProperty.all( const EdgeInsets.all(8)),
                                minimumSize: MaterialStateProperty.all( const Size(50, 50)),
                              ),
                            ),
                  ),
                  SizedBox(
                    height: widget.fromBoarding ? 80 : 0,
                  )
                ],
              ),
            ]),
            ),
          ],
        ),
            drawer: !widget.fromBoarding ? MainDrawer() : null,
          ),
    );
  }
}
