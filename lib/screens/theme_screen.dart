import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/mainDrawer.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeScreen extends StatefulWidget {
  static String routeName = '/ThemeScreen';
  final bool fromBoarding;

  ThemeScreen({this.fromBoarding = false});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  var newPrimary;

  var newAccent;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    bool isLandScabe =
        MediaQuery.of(context).orientation == Orientation.landscape;
    Widget buildListTile(BuildContext ctx, String title) {
      var primaryColor =
          Provider.of<ThemeProvidr>(ctx, listen: true).primeryColor;
      var canvasColor =
          Provider.of<ThemeProvidr>(ctx, listen: true).canvasColor;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            '${lan.getTexts(title)}' ' ${lan.getTexts('$title-keyword')}',
            style: Theme.of(ctx).textTheme.bodyText2,
          ),
          trailing: CircleAvatar(
            backgroundColor: title == 'primary' ? primaryColor : canvasColor,
          ),
          onTap: () {
            showDialog(
              context: ctx,
              builder: (BuildContext ctn) {
                return AlertDialog(
                  backgroundColor: Theme.of(ctn).colorScheme.secondary,
                  elevation: 4,
                  titlePadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    height: isLandScabe
                        ? MediaQuery.of(ctx).size.height / 1.4
                        : MediaQuery.of(ctx).size.height / 1.9,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ColorPicker(
                            pickerColor: title == 'primary'
                                ? primaryColor
                                : canvasColor,
                            onColorChanged: (Color newColor) {
                              setState(() {
                                title == 'primary'
                                    ? newPrimary = newColor
                                    : newAccent = newColor;
                              });
                            },
                            colorPickerWidth: 300.0,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: true,
                            labelTextStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            colorHistory: [
                              primaryColor,
                              canvasColor,
                            ],
                            displayThumbColor: true,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(25)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<ThemeProvidr>(ctx, listen: false)
                                    .onChange(
                                        title == 'primary'
                                            ? newPrimary
                                            : newAccent,
                                        title == 'primary' ? 1 : 2);
                              },
                              child: Text(
                                '${lan.getTexts('save_filters')}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                )),
                                overlayColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(8)),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(50, 50)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 85,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              primary: false,
              centerTitle: true,
              backgroundColor: widget.fromBoarding
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColor,
              title: widget.fromBoarding
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('${lan.getTexts('theme_appBar_title')}')),
              elevation: widget.fromBoarding ? 0.0 : 5,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Text(
                        '${lan.getTexts('theme_screen_title')}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      Text(
                        '${lan.getTexts('theme_mode_title')}',
                        textAlign: TextAlign.start,
                      ),
                      buildRadioListTile(
                          ThemeMode.system,
                          context,
                          '${lan.getTexts('System_default_theme')}',
                          Container(
                            width: 0.0,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      buildRadioListTile(
                          ThemeMode.light,
                          context,
                          '${lan.getTexts('light_theme')}',
                          Icon(Icons.wb_sunny_outlined,
                              color: Theme.of(context).colorScheme.secondary)),
                      const SizedBox(
                        height: 15,
                      ),
                      buildRadioListTile(
                          ThemeMode.dark,
                          context,
                          '${lan.getTexts('dark_theme')}',
                          Icon(
                            Icons.dark_mode,
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                      const SizedBox(
                        height: 35,
                      ),
                      buildListTile(context, 'primary'),
                      const SizedBox(
                        height: 15,
                      ),
                      buildListTile(context, 'accent'),
                      SizedBox(
                        height: widget.fromBoarding ? 80 : 0,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: !widget.fromBoarding ? MainDrawer() : null,
      ),
    );
  }

  RadioListTile<ThemeMode> buildRadioListTile(
      ThemeMode themeMode, BuildContext context, String title, Widget icon) {
    return RadioListTile(
      value: themeMode,
      groupValue: Provider.of<ThemeProvidr>(context, listen: true).themeMood,
      onChanged: (newThemeVal) {
        Provider.of<ThemeProvidr>(context, listen: false)
            .themeModeChange(newThemeVal);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      activeColor: Theme.of(context).primaryColor,
      secondary: icon,
    );
  }
}
