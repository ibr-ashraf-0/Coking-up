import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/language_provider.dart';
import '../provider/mael_provider.dart';
import '../provider/theme_provider.dart';
import '../widgets/mainDrawer.dart';
import 'category_screen.dart';
import 'favoriteScreen.dart';

class TapsScreen extends StatefulWidget {

  static const routName = '/TapBarScreen';
  @override
  _TapsScreenState createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
  late List<Map<String, Object>> pages;
  int selectedPageIndex = 0;

  @override
  void initState() {
    Provider.of<MaelProvider>(context,listen: false).getSharedData();
    Provider.of<MaelProvider>(context,listen: false).setFiltters();
    Provider.of<ThemeProvidr>(context,listen: false).getThemeFromSharedPref();
    Provider.of<ThemeProvidr>(context,listen: false).getColorsFromSharedPref();
    Provider.of<LanguageProvider>(context,listen: false).getLan();


    super.initState();
  }

  void selectedPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context,listen: true);
    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildListDelegate([
              selectedPageIndex == 0 ? SizedBox(height: MediaQuery.of(context).size.height,child: CategoriesScreen()) : SizedBox(height: MediaQuery.of(context).size.height,child: FavoriteScreen()),
            ]),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.category), label: lan.getTexts('category_navBar'),),
            BottomNavigationBarItem(
                icon: const Icon(Icons.favorite), label: lan.getTexts('favorites_navBar'),),
          ],
          onTap: selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.black,

          currentIndex: selectedPageIndex,
           showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedIconTheme: const IconThemeData(
              color: Colors.black,
              size: 22,
          ),
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.secondary,
            size: 25
          ),
          unselectedFontSize: 18,
          selectedFontSize: 20,
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
