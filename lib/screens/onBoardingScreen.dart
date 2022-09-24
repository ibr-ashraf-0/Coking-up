import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/language_provider.dart';
import 'filters_screen.dart';
import 'taps_screen.dart';
import 'theme_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/images/onBoarding.jpg',
                        scale: 1),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.black54,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Text(
                        '${lan.getTexts('start')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black54,
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          Text('${lan.getTexts('drawer_switch_title')}',style: const TextStyle(color: Colors.white),),
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
                    ),
                  ],
                ),
              ),
              ThemeScreen(fromBoarding: true),
              FiltersScreen(fromBoarding: true),
            ],
          ),
          Builder(
            builder: (ctx) {
              return Align(
                alignment: const Alignment(0, 0.85),
                child: Container(
                  width: MediaQuery.of(ctx).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          TapsScreen.routName, (route) => false);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('showBoarding', true);
                    },
                    child: Text(
                      '${lan.getTexts('start')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Theme.of(ctx).primaryColor),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.zero,
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      minimumSize: MaterialStateProperty.all(Size(
                          double.infinity,
                          MediaQuery.of(ctx).size.height / 15)),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
