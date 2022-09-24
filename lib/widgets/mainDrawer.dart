import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';
import '../screens/filters_screen.dart';
import '../screens/theme_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(
      String title, IconData icons, Function tapHandler, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        iconColor: Theme.of(ctx).primaryColor,
        leading: Icon(
          icons,
          size: 26,
        ),
        title: Text(title, style: Theme.of(ctx).textTheme.subtitle1),
        onTap: () {
          tapHandler();
        },
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(ctx).primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              height: 100,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black, Theme.of(context).primaryColor],
                begin: lan.isEn ? Alignment.topLeft : Alignment.topRight,
                end: lan.isEn ? Alignment.bottomRight : Alignment.bottomLeft,
                stops: lan.isEn ? [0.67, 0.33] : [0.511, 0.499],
              )),
              width: MediaQuery.of(context).size.width,
              child: Text(
                '${lan.getTexts('drawer_name')}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildListTile('${lan.getTexts('drawer_item1')}', Icons.restaurant,
                () {
              Navigator.of(context).pushReplacementNamed('/');
            }, context),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black38,
              ),
              margin: const EdgeInsets.all(8),
              child: ExpansionTile(
                collapsedIconColor: Theme.of(context).primaryColor,
                iconColor: Theme.of(context).primaryColor,
                collapsedTextColor: Colors.white,
                textColor: Theme.of(context).colorScheme.secondary,
                leading: const Icon(Icons.settings),
                title: Text('${lan.getTexts('drawer_item2')}'),
                children: [
                  Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      thickness: 1.5),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: const EdgeInsets.all(8),
                    color: Theme.of(context).canvasColor.withOpacity(1),
                    child: ListTile(
                      leading: Icon(
                        Icons.filter_alt_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        '${lan.getTexts('drawer_item3')}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(FiltersScreen.routeName);
                      },
                    ),
                  ),
                  Card(
                    color: Theme.of(context).canvasColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(
                        Icons.color_lens_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        '${lan.getTexts('drawer_item4')}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(ThemeScreen.routeName);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Provider.of<ThemeProvidr>(context).themeMood ==
                              ThemeMode.light
                          ? Colors.black12
                          : Colors.white24,
                    ),
                    child: ExpansionTile(
                      collapsedIconColor: Theme.of(context).primaryColor,
                      iconColor: Theme.of(context).primaryColor,
                      collapsedTextColor: Colors.white,
                      textColor: Theme.of(context).colorScheme.secondary,
                      controlAffinity: ListTileControlAffinity.trailing,
                      backgroundColor: Colors.transparent,
                      title: Text('${lan.getTexts('drawer_switch_title')}'),
                      leading: const Icon(Icons.language),
                      children: [
                        Divider(
                            color: Theme.of(context).colorScheme.secondary,
                            thickness: 1.5),
                        Card(
                          shadowColor: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          margin: const EdgeInsets.all(8),
                          color: Theme.of(context).canvasColor.withOpacity(1),
                          child: ListTile(
                            trailing: Text(
                                '${lan.getTexts('drawer_switch_item1')}',
                                style: Theme.of(context).textTheme.headline4),
                            leading: Text(
                                '${lan.getTexts('drawer_switch_item2')}',
                                style: Theme.of(context).textTheme.headline4),
                            title: Switch(
                              value: Provider.of<LanguageProvider>(context,
                                      listen: true)
                                  .isEn,
                              onChanged: (newVal) {
                                Provider.of<LanguageProvider>(context,
                                        listen: false)
                                    .changeLan(newVal);
                                Navigator.of(context).pop();
                              },
                              activeColor: Theme.of(context).primaryColor,
                              inactiveThumbColor:
                                  Theme.of(context).primaryColor,
                              inactiveTrackColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
