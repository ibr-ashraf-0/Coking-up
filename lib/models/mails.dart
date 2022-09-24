enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability { Affordable, Pricey, Luxurions }

class Mail {
  final String id;
  final List<String> categories;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool inGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Mail(
      {required this.id,
      required this.categories,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.inGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian});
}
