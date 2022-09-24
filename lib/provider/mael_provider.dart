

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../date.dart';
import '../models/cotegare.dart';
import '../models/mails.dart';

class MaelProvider extends ChangeNotifier {
  List<Mail> availableMael = DUMMY_MEALS;
  List<Mail> favouriteMael = [];
  List<String> malesIds = [];
  List<Cotegare> availableCategory = [];

  Map<String, bool> filters = {
    'gluten': false,
    'Lactose': false,
    'Vegetarian': false,
    'Vegan': false,
  };


  void getSharedData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    filters['gluten'] = pref.getBool('gluten') ?? false;
    filters['Lactose'] = pref.getBool('Lactose') ?? false;
    filters['Vegetarian'] = pref.getBool('Vegetarian') ?? false;
    filters['Vegan'] = pref.getBool('Vegan') ?? false;
    List<String> prefsMaelsIds = pref.getStringList('prefIds') ?? [];
    for (String ids in prefsMaelsIds) {
      final existingIndex = favouriteMael.indexWhere((meal) => meal.id == ids);
      if (existingIndex < 0) {
        favouriteMael.add(DUMMY_MEALS.firstWhere((meal) => meal.id == ids));
      }
    }
    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    final existingIndex = favouriteMael.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      favouriteMael.removeAt(existingIndex);
      malesIds.remove(mealId);
    } else {
      favouriteMael.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      malesIds.add(mealId);
    }

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('prefIds', malesIds);
  }

  bool isFavorite(String mealId) {
    return favouriteMael.any((meal) => meal.id == mealId);
  }

  void setFiltters() async {
    availableMael = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.inGlutenFree) {
        return false;
      }
      if (filters['Lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['Vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (filters['Vegan']! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('gluten', filters['gluten']!);
    pref.setBool('Lactose', filters['Lactose']!);
    pref.setBool('Vegetarian', filters['Vegetarian']!);
    pref.setBool('Vegan', filters['Vegan']!);

    List<Cotegare> ac = [];
    availableMael.forEach((male) {
      male.categories.forEach((maleCategoryId) {
        DUMMY_CATEGORIES.forEach((category) {
          if (category.id == maleCategoryId) {
            if (!ac.any((male) => male.id == maleCategoryId)) ac.add(category);
          }
        });
      });
    });
    availableCategory = ac;
    notifyListeners();
  }

  void removeItem(String id) {
    favouriteMael.removeWhere((meal) => meal.id == id);
    availableCategory.removeWhere((cat) => cat.id == id);
    availableMael.removeWhere((meal) => meal.id == id);
    notifyListeners();
  }
}
