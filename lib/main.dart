import 'package:flutter/material.dart';
import './provider/mael_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/language_provider.dart';
import 'provider/theme_provider.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/onBoardingScreen.dart';
import 'screens/taps_screen.dart';
import 'screens/theme_screen.dart';

var mainScreen;

main() async {
  WidgetsFlutterBinding();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  mainScreen = (prefs.getBool('showBoarding') == true || prefs.getBool('showBoarding') != null) ? TapsScreen(): OnBoardingScreen();
  runApp(
  MultiProvider(
  providers: [
    ChangeNotifierProvider<MaelProvider>(create: (context)=> MaelProvider(),),
    ChangeNotifierProvider<ThemeProvidr>(create: (context)=> ThemeProvidr(),),
    ChangeNotifierProvider<LanguageProvider>(create: (context)=> LanguageProvider(),),
  ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var primaryColor = Provider.of<ThemeProvidr>(context,listen: true).primeryColor;
    var canvasColor = Provider.of<ThemeProvidr>(context,listen: true).canvasColor;
    var tm = Provider.of<ThemeProvidr>(context,listen: true).themeMood;
    return MaterialApp(
      themeMode: tm,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: Colors.white,
        iconTheme: IconThemeData(
          color: canvasColor,
          size: 25,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Raleway.Bold.ttf',
                overflow: TextOverflow.ellipsis,
              ),
              bodyText2: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontFamily: 'Raleway-Regular.ttf',
              ),
              headline1: const TextStyle(
                color: Colors.black, fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
          headline2: const TextStyle(
            color: Colors.black, fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline4: const TextStyle(
            color: Colors.black, fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
              headline5: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: canvasColor),
              headline6: const TextStyle(
                  color: Colors.white,
                fontSize: 16,
                fontFamily: 'RobotoCondensed.Bold.ttf',
              ),
          subtitle1: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
          ),
          subtitle2: const TextStyle(
            fontSize: 13.5,
            color: Colors.black,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
          ),
            ),
        unselectedWidgetColor: Colors.black54,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor,).copyWith(secondary: canvasColor),
      ),
      darkTheme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 25,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Raleway.Bold.ttf',
            overflow: TextOverflow.ellipsis,
          ),
          bodyText2: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Raleway-Regular.ttf',
          ),
          headline1: const TextStyle(
            color: Colors.white, fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline2: const TextStyle(
            color: Colors.white, fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline4: const TextStyle(
            color: Colors.white, fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: canvasColor),
          headline6: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'RobotoCondensed.Bold.ttf',
          ),
          subtitle1: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
          ),
          subtitle2: const TextStyle(
            fontSize: 13.5,
            color: Colors.white,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: canvasColor),
        unselectedWidgetColor: Colors.white70,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => mainScreen,
        TapsScreen.routName: (context) => TapsScreen(),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(),
        ThemeScreen.routeName: (context) =>
            ThemeScreen(),
      },
    );
  }
}
